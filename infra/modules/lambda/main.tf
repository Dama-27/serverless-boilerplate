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
    aws_iam_role_policy_attachment.lambda_basic_execution,
    aws_cloudwatch_log_group.lambda_log
  ]
}

# ------------------------------------------------------------------------------
# API Gateway Integration (REST API) 
# Deployed only if rest_api_id and api_path are provided
# ------------------------------------------------------------------------------

resource "aws_api_gateway_resource" "this" {
  count       = var.api_path != "" ? 1 : 0
  rest_api_id = var.rest_api_id
  parent_id   = var.rest_api_root_resource_id
  path_part   = var.api_path
}

resource "aws_api_gateway_method" "this" {
  count         = var.api_path != "" ? 1 : 0
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.this[0].id
  http_method   = var.http_method
  authorization = var.authorizer_id != "" ? "COGNITO_USER_POOLS" : "NONE"
  authorizer_id = var.authorizer_id != "" ? var.authorizer_id : null
}

resource "aws_api_gateway_integration" "this" {
  count                   = var.api_path != "" ? 1 : 0
  rest_api_id             = var.rest_api_id
  resource_id             = aws_api_gateway_resource.this[0].id
  http_method             = aws_api_gateway_method.this[0].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.this.invoke_arn
}

resource "aws_lambda_permission" "api_gw" {
  count         = var.api_path != "" ? 1 : 0
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${var.rest_api_execution_arn}/*/${var.http_method}/${var.api_path}"
}
