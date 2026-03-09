# Networking module
# Provides security groups and network configuration

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "security_group_name" {
  description = "Security group name"
  type        = string
}

variable "ingress_rules" {
  description = "Ingress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = []
}
