variable "name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "cognito_user_pool_arn" {
  description = "Optional Cognito User Pool ARN for authorizer"
  type        = string
  default     = ""
}
