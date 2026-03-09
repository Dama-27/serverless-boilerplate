# Development Environment Backend Configuration

terraform {
  backend "s3" {
    bucket         = "serverless-mern-terraform-state-dev"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks-dev"
  }
}
