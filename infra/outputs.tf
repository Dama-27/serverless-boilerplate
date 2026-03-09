output "api_gateway_endpoint" {
  description = "API Gateway endpoint URL"
  value       = "https://api.example.com"
}

output "cognito_user_pool_id" {
  description = "Cognito User Pool ID"
  value       = "us-east-1_xxxxx"
}

output "dynamodb_users_table" {
  description = "DynamoDB Users table name"
  value       = "users-${var.environment}"
}

output "eventbridge_bus_name" {
  description = "EventBridge bus name"
  value       = "${var.project_name}-${var.environment}"
}

output "s3_uploads_bucket" {
  description = "S3 uploads bucket name"
  value       = "${var.project_name}-uploads-${var.environment}"
}
