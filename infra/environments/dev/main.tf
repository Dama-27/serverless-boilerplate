provider "aws" {
  region = var.aws_region

  default_tags {
    tags = local.tags
  }
}

locals {
  environment_prefix = "${var.project_name}-${var.environment}"
  
  dynamodb_tables = {
    employee = "employee-${var.environment}"
  }

  tags = {
    Environment = var.environment
    Project     = var.project_name
    ManagedBy   = "Terraform"
  }
}

module "employee" {
  source       = "../../modules/dynamodb"
  table_name   = local.dynamodb_tables.employee
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "employee_id"
  range_key    = "join_date"
  attributes = [
    { name = "employee_id", type = "S" },
    { name = "join_date", type = "S" }
  ]
  gsI = [
    {
      name            = "join_date-index"
      hash_key        = "join_date"
      projection_type = "ALL"
    }
  ]
}

module "api_gateway" {
  source      = "../../modules/api_gateway"
  name        = "${var.project_name}-api-${var.environment}"
  environment = var.environment
  
  # cognito_user_pool_arn = var.cognito_user_pool_arn # Optional
}

module "lambda_health" {
  source            = "../../modules/lambda"
  function_name     = "${var.project_name}-health-${var.environment}"
  environment       = var.environment
  handler           = "domains/health/handlers/lambda-health.handler.handler"
  
  source_dir        = "${path.module}/../../../apps/backend/dist"
  build_command     = ""
  build_working_dir = "${path.module}/../../../apps/backend"
  
  rest_api_id               = module.api_gateway.api_id
  rest_api_root_resource_id = module.api_gateway.root_resource_id
  rest_api_execution_arn    = module.api_gateway.execution_arn
  api_path                  = "health"
  http_method               = "GET"
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = module.api_gateway.api_id

  triggers = {
    redeployment = timestamp()
  }

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    module.lambda_health
  ]
}

resource "aws_api_gateway_stage" "api_stage" {
  deployment_id = aws_api_gateway_deployment.api_deployment.id
  rest_api_id   = module.api_gateway.api_id
  stage_name    = var.environment
}

