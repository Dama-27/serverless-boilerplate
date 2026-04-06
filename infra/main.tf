provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "Terraform"
      CreatedAt   = timestamp()
    }
  }
}

module "employee" {
  source       = "./modules/dynamodb"
  table_name   = local.dynamodb_tables.employee
  billing_mode = var.dynamodb_billing_mode
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

module "eventbus" {
  source   = "./modules/eventbridge"
  bus_name = local.eventbridge_bus_name
}

module "uploads_bucket" {
  source      = "./modules/s3"
  bucket_name = local.s3_buckets.uploads
  environment = var.environment
  versioning_enabled = true
}
