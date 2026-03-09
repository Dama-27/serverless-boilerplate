# IAM module
# Provides role and policy configuration

variable "role_name" {
  description = "IAM role name"
  type        = string
}

variable "assume_role_policy" {
  description = "Assume role policy"
  type        = string
}

variable "policies" {
  description = "List of policy ARNs to attach"
  type        = list(string)
  default     = []
}

variable "inline_policies" {
  description = "Inline policies"
  type = list(object({
    name   = string
    policy = string
  }))
  default = []
}
