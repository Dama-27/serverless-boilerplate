#!/bin/bash
set -e

echo "✅ Validating Terraform..."
cd infra

terraform validate

echo "✅ Terraform validation complete!"
