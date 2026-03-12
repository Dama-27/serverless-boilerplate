provider "aws" {
  region = var.aws_region
}

module "s3_bucket" {
  source = "../../modules/s3"

  bucket_name = var.bucket_name
  environment = var.environment

  lifecycle_rules = [
    {
      id   = "cleanup-temp-files"
      days = 7
    }
  ]

  tags = {
    Project = "example-project"
  }
}