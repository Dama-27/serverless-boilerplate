#!/bin/bash
set -e

echo "📝 Seeding DynamoDB with test data..."

# LocalStack endpoint
ENDPOINT="http://localhost:4566"
REGION="us-east-1"

# Seeds users
echo "👥 Seeding users table..."
aws dynamodb put-item \
  --endpoint-url=$ENDPOINT \
  --region=$REGION \
  --table-name=users-dev \
  --item '{
    "id": {"S": "user-1"},
    "email": {"S": "john@example.com"},
    "firstName": {"S": "John"},
    "lastName": {"S": "Doe"},
    "createdAt": {"S": "2024-01-01T00:00:00Z"},
    "updatedAt": {"S": "2024-01-01T00:00:00Z"}
  }'

echo "✅ Database seeding complete!"
