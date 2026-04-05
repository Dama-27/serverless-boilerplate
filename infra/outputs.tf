output "cognito_user_pool_id" {
  description = "Cognito User Pool ID"
  value       = "us-east-1_xxxxx" # Placeholder since Cognito module is not fully implemented
}

output "dynamodb_users_table" {
  description = "DynamoDB Users table name"
  value       = module.users_table.table_name
}

output "dynamodb_orders_table" {
  description = "DynamoDB Orders table name"
  value       = module.orders_table.table_name
}

output "dynamodb_notifications_table" {
  description = "DynamoDB Notifications table name"
  value       = module.notifications_table.table_name
}

output "eventbridge_bus_name" {
  description = "EventBridge bus name"
  value       = module.eventbus.bus_name
}

output "s3_uploads_bucket" {
  description = "S3 uploads bucket name"
  value       = module.uploads_bucket.bucket_name
}
