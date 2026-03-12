variable "bucket_name" {
  description = "Base name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable bucket versioning"
  type        = bool
  default     = true
}

variable "encryption_enabled" {
  description = "Enable server side encryption"
  type        = bool
  default     = true
}

variable "public_access_blocked" {
  description = "Block all public access"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}

variable "lifecycle_rules" {
  description = "Lifecycle rules for the bucket"
  type = list(object({
    id     = string
    days   = number
    prefix = optional(string)
  }))
  default = []
}