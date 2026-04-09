output "cognito_user_pool_id" {
  description = "Cognito User Pool ID"
  value       = "us-east-1_xxxxx" # Placeholder since Cognito module is not fully implemented
}


output "eventbridge_bus_name" {
  description = "EventBridge bus name"
  value       = module.eventbus.bus_name
}

output "s3_uploads_bucket" {
  description = "S3 uploads bucket name"
  value       = module.uploads_bucket.bucket_name
}

output "lambda_health_api_url" {
  description = "The HTTP API Gateway endpoint for lambda health function"
  value       = module.lambda_health.api_endpoint
}
