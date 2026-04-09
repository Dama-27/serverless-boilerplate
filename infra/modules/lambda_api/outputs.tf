output "api_endpoint" {
  description = "The HTTP API Gateway endpoint URL"
  value       = aws_apigatewayv2_stage.default.invoke_url
}

output "function_name" {
  description = "The name of the Lambda function"
  value       = aws_lambda_function.this.function_name
}
