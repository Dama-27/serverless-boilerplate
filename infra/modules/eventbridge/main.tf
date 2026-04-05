resource "aws_cloudwatch_event_bus" "this" {
  name = var.bus_name
}

resource "aws_cloudwatch_event_rule" "this" {
  count          = length(var.event_rules)
  name           = var.event_rules[count.index].name
  description    = var.event_rules[count.index].description
  event_bus_name = aws_cloudwatch_event_bus.this.name
  event_pattern  = jsonencode(var.event_rules[count.index].event_pattern)
}

resource "aws_cloudwatch_event_target" "this" {
  count     = length(var.event_rules)
  rule      = aws_cloudwatch_event_rule.this[count.index].name
  target_id = var.event_rules[count.index].name
  arn       = var.event_rules[count.index].target_arn
  event_bus_name = aws_cloudwatch_event_bus.this.name
}
