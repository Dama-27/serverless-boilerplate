# S3 module
# Provides S3 bucket configuration

variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
}

variable "versioning_enabled" {
  description = "Enable versioning"
  type        = bool
  default     = true
}

variable "encryption_enabled" {
  description = "Enable encryption"
  type        = bool
  default     = true
}

variable "public_access_blocked" {
  description = "Block public access"
  type        = bool
  default     = true
}

variable "lifecycle_rules" {
  description = "Lifecycle rules"
  type = list(object({
    prefix   = string
    days     = number
    action   = string
  }))
  default = []
}
