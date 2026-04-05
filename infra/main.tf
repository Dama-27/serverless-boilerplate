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

module "users_table" {
  source       = "./modules/dynamodb"
  table_name   = local.dynamodb_tables.users
  billing_mode = var.dynamodb_billing_mode
  hash_key     = "id"
  attributes = [
    { name = "id", type = "S" },
    { name = "email", type = "S" }
  ]
  gsI = [
    {
      name            = "email-index"
      hash_key        = "email"
      projection_type = "ALL"
    }
  ]
}

module "orders_table" {
  source       = "./modules/dynamodb"
  table_name   = local.dynamodb_tables.orders
  billing_mode = var.dynamodb_billing_mode
  hash_key     = "id"
  attributes = [
    { name = "id", type = "S" },
    { name = "userId", type = "S" }
  ]
  gsI = [
    {
      name            = "userId-index"
      hash_key        = "userId"
      projection_type = "ALL"
    }
  ]
}

module "notifications_table" {
  source       = "./modules/dynamodb"
  table_name   = local.dynamodb_tables.notifications
  billing_mode = var.dynamodb_billing_mode
  hash_key     = "id"
  attributes = [
    { name = "id", type = "S" },
    { name = "userId", type = "S" }
  ]
  gsI = [
    {
      name            = "userId-index"
      hash_key        = "userId"
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
