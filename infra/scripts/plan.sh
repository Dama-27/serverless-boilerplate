#!/bin/bash
set -e

ENVIRONMENT=${1:-.}

if [ "$ENVIRONMENT" = "." ]; then
  echo "Usage: ./plan.sh <dev|staging|prod>"
  exit 1
fi

echo "📋 Planning Terraform for $ENVIRONMENT..."
cd infra

terraform init -backend-config="environments/$ENVIRONMENT/backend.tf"
terraform plan \
  -var-file="environments/$ENVIRONMENT/terraform.tfvars" \
  -out=tfplan_$ENVIRONMENT

echo "✅ Terraform plan complete for $ENVIRONMENT!"
echo "Review: terraform show tfplan_$ENVIRONMENT"
