#!/bin/bash
set -e

ENVIRONMENT=${1:-.}

if [ "$ENVIRONMENT" = "." ]; then
  echo "Usage: ./deploy.sh <dev|staging|prod>"
  exit 1
fi

echo "🚀 Deploying Terraform for $ENVIRONMENT..."
cd infra

terraform init -backend-config="environments/$ENVIRONMENT/backend.tf"
terraform apply \
  -var-file="environments/$ENVIRONMENT/terraform.tfvars" \
  -auto-approve

echo "✅ Terraform deployment complete for $ENVIRONMENT!"
