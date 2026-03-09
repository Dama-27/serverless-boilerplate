# EventBridge module
# Provides event bus and rules configuration

variable "bus_name" {
  description = "EventBridge bus name"
  type        = string
}

variable "event_rules" {
  description = "Event rules"
  type = list(object({
    name           = string
    description    = string
    event_pattern  = any
    target_arn     = string
  }))
  default = []
}
