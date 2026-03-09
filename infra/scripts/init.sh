#!/bin/bash
set -e

echo "🔧 Initializing Terraform..."
cd infra

# Initialize Terraform for each environment
for env in dev staging prod; do
  echo "Initializing $env environment..."
  terraform init -backend-config="environments/$env/backend.tf"
done

echo "✅ Terraform initialization complete!"
