# DynamoDB module
# Provides reusable DynamoDB table configuration

variable "table_name" {
  description = "DynamoDB table name"
  type        = string
}

variable "billing_mode" {
  description = "DynamoDB billing mode"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "Hash key attribute"
  type        = string
}

variable "range_key" {
  description = "Range key attribute (optional)"
  type        = string
  default     = ""
}

variable "attributes" {
  description = "List of attributes"
  type = list(object({
    name = string
    type = string
  }))
}

variable "gsI" {
  description = "Global Secondary Indexes"
  type = list(object({
    name           = string
    hash_key       = string
    range_key      = optional(string)
    projection_type = string
  }))
  default = []
}
