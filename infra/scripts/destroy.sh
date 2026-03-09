#!/bin/bash
set -e

ENVIRONMENT=${1:-.}

if [ "$ENVIRONMENT" = "." ]; then
  echo "Usage: ./destroy.sh <dev|staging|prod>"
  exit 1
fi

echo "⚠️  WARNING: This will destroy all infrastructure in $ENVIRONMENT!"
read -p "Are you sure? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
  echo "Cancelled."
  exit
fi

echo "🗑️  Destroying Terraform for $ENVIRONMENT..."
cd infra

terraform init -backend-config="environments/$ENVIRONMENT/backend.tf"
terraform destroy \
  -var-file="environments/$ENVIRONMENT/terraform.tfvars" \
  -auto-approve

echo "✅ Terraform destruction complete for $ENVIRONMENT!"
