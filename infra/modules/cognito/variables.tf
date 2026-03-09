# Cognito module
# Provides user pool and client configuration

variable "pool_name" {
  description = "Cognito user pool name"
  type        = string
}

variable "client_name" {
  description = "Cognito client name"
  type        = string
}

variable "mfa_enabled" {
  description = "Enable MFA"
  type        = bool
  default     = false
}

variable "password_policy" {
  description = "Password policy"
  type = object({
    minimum_length    = number
    require_uppercase = bool
    require_lowercase = bool
    require_numbers   = bool
    require_symbols   = bool
  })
  default = {
    minimum_length    = 8
    require_uppercase = true
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
  }
}
