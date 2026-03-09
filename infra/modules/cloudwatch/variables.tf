# CloudWatch module
# Provides log groups and alarms configuration

variable "log_group_name" {
  description = "CloudWatch log group name"
  type        = string
}

variable "retention_days" {
  description = "Log retention in days"
  type        = number
  default     = 7
}

variable "alarms" {
  description = "CloudWatch alarms"
  type = list(object({
    name        = string
    description = string
    metric      = string
    threshold   = number
    comparison  = string
  }))
  default = []
}
