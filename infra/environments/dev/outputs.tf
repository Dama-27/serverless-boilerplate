output "api_gateway_url" {
  description = "The REST API Gateway endpoint URL"
  value       = aws_api_gateway_stage.api_stage.invoke_url
}

output "lambda_health_arn" {
  description = "The ARN of the Lambda Health Function"
  value       = module.lambda_health.function_arn
}
