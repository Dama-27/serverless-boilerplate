output "api_gateway_url" {
  description = "The REST API Gateway endpoint URL"
  value       = module.api_gateway.api_endpoint
}

output "lambda_health_arn" {
  description = "The ARN of the Lambda Health Function"
  value       = module.lambda_health.function_arn
}
