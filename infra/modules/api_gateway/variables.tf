variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
