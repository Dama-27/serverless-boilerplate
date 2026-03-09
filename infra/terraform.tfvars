# Create a .tfvars file named terraform.tfvars with content from this template
# and adjust values as needed

aws_region = "us-east-1"
environment = "dev"
project_name = "serverless-mern"
api_stage_name = "dev"
lambda_memory_size = 512
lambda_timeout = 30
dynamodb_billing_mode = "PAY_PER_REQUEST"
cognito_mfa_enabled = false
