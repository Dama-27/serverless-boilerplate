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
