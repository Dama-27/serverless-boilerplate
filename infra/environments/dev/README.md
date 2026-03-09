# Environment-specific configurations

## Development (dev)

```bash
AWS_REGION=us-east-1
ENVIRONMENT=dev
API_STAGE=dev
LAMBDA_MEMORY_SIZE=256
```

Use LocalStack for testing.

## Staging

```bash
AWS_REGION=us-east-1
ENVIRONMENT=staging
API_STAGE=staging
LAMBDA_MEMORY_SIZE=512
```

Full AWS stack, private subnets.

## Production

```bash
AWS_REGION=us-east-1
ENVIRONMENT=prod
API_STAGE=prod
LAMBDA_MEMORY_SIZE=1024
```

Multi-AZ, encryption at rest, backup enabled.
