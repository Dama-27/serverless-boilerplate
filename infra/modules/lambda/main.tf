resource "null_resource" "build" {
  count = var.build_command != "" ? 1 : 0

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command     = var.build_command
    working_dir = var.build_working_dir != "" ? var.build_working_dir : path.module
  }
}

data "archive_file" "lambda_zip" {
  depends_on  = [null_resource.build]
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "${path.module}/.terraform/archive/${var.function_name}.zip"
}

resource "aws_iam_role" "lambda_exec" {
  name = "${var.function_name}-exec-role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "this" {
  function_name    = var.function_name
  role             = aws_iam_role.lambda_exec.arn
  handler          = var.handler
  runtime          = var.runtime
  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  environment {
    variables = {
      NODE_ENV = var.environment
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_policy
  ]
}

# ------------------------------------------------------------------------------
# API Gateway Integration (deployed only if api_id and api_path are provided)
# ------------------------------------------------------------------------------

resource "aws_apigatewayv2_integration" "lambda" {
  count              = var.api_id != "" && var.api_path != "" ? 1 : 0
  api_id             = var.api_id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.this.invoke_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "this" {
  count     = var.api_id != "" && var.api_path != "" ? 1 : 0
  api_id    = var.api_id
  route_key = "GET ${var.api_path}"
  target    = "integrations/${aws_apigatewayv2_integration.lambda[0].id}"
}

resource "aws_lambda_permission" "api_gw" {
  count         = var.api_execution_arn != "" && var.api_path != "" ? 1 : 0
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.api_execution_arn}/*/*"
}
