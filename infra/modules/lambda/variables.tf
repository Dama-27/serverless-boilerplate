variable "function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "handler" {
  description = "Lambda function handler"
  type        = string
  default     = "index.handler"
}

variable "runtime" {
  description = "Lambda runtime"
  type        = string
  default     = "nodejs18.x"
}

variable "source_dir" {
  description = "Path to the directory containing the lambda source code"
  type        = string
}

variable "build_command" {
  description = "Optional command to run before zipping the lambda source"
  type        = string
  default     = ""
}

variable "build_working_dir" {
  description = "Working directory for the build command"
  type        = string
  default     = ""
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "rest_api_id" {
  description = "REST API Gateway ID (optional)"
  type        = string
  default     = ""
}

variable "rest_api_root_resource_id" {
  description = "REST API Gateway Root Resource ID (optional)"
  type        = string
  default     = ""
}

variable "rest_api_execution_arn" {
  description = "REST API Gateway Execution ARN (optional)"
  type        = string
  default     = ""
}

variable "api_path" {
  description = "REST API path part (e.g. 'health')"
  type        = string
  default     = ""
}

variable "http_method" {
  description = "REST API HTTP method"
  type        = string
  default     = "GET"
}

variable "authorizer_id" {
  description = "Optional API Gateway Authorizer ID"
  type        = string
  default     = ""
}
