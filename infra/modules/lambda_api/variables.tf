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
  description = "Path to the directory containing the lambda source code (e.g. dist folder)"
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

variable "api_path" {
  description = "API Gateway route path"
  type        = string
  default     = "/health"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}
