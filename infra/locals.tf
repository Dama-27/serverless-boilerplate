# Local variables for common values
locals {
  environment_prefix = "${var.project_name}-${var.environment}"
  
  # DynamoDB table names
  dynamodb_tables = {
    users         = "users-${var.environment}"
    orders        = "orders-${var.environment}"
    notifications = "notifications-${var.environment}"
    employee      = "employee-${var.environment}"
  }

  # Lambda common configuration
  lambda_config = {
    memory_size = var.lambda_memory_size
    timeout     = var.lambda_timeout
    runtime     = "nodejs18.x"
    environment = var.environment
  }

  # S3 bucket names
  s3_buckets = {
    uploads = "${var.project_name}-uploads-${var.environment}"
    assets  = "${var.project_name}-assets-${var.environment}"
  }

  # EventBridge
  eventbridge_bus_name = "${var.project_name}-${var.environment}"

  # Common tags
  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}
