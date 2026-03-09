# Terraform module for API Gateway

variable "api_name" {
  description = "API Gateway name"
  type        = string
}

variable "stage_name" {
  description = "API stage name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

output "api_endpoint" {
  description = "API Gateway invoke URL"
  value       = "https://api.example.com"
}
