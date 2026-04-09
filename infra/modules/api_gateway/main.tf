resource "aws_api_gateway_rest_api" "this" {
  name        = var.name
  description = "REST API for ${var.environment}"
  
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

# Optional Cognito Authorizer
resource "aws_api_gateway_authorizer" "cognito" {
  count         = var.cognito_user_pool_arn != "" ? 1 : 0
  name          = "${var.name}-authorizer"
  rest_api_id   = aws_api_gateway_rest_api.this.id
  type          = "COGNITO_USER_POOLS"
  provider_arns = [var.cognito_user_pool_arn]
}

# To trigger a deployment on changes, we hash the API setup. 
# For scale, many prefer a separate module or specific triggers, 
# but a dynamic timestamp allows safe automatic deployments when tested.
resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = timestamp()
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.environment
}
