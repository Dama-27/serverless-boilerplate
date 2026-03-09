# Deployment Guide

## Environments

Three deployment environments:
- **dev**: Development and testing
- **staging**: Pre-production validation
- **prod**: Production

## Prerequisites

### AWS Account Setup

1. Create AWS account and get credentials
2. Install and configure AWS CLI:
```bash
aws configure
```

3. Create backend state bucket (per environment):
```bash
aws s3 mb s3://serverless-mern-terraform-state-dev
aws s3api put-bucket-versioning \
  --bucket serverless-mern-terraform-state-dev \
  --versioning-configuration Status=Enabled
```

4. Create DynamoDB locks table:
```bash
aws dynamodb create-table \
  --table-name terraform-locks-dev \
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  --key-schema AttributeName=LockID,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST
```

### GitHub Secrets

Configure in repo Settings > Secrets:
- `AWS_ACCOUNT_ID`: AWS account number
- `AWS_ACCOUNT_ID_PROD`: Production AWS account
- `SLACK_WEBHOOK`: For deployment notifications

## Deployment Process

### Manual Deployment

#### 1. Build and Test

```bash
npm run build
npm run test
npm run lint
```

#### 2. Plan Infrastructure

```bash
npm run terraform:plan -- -var-file=infra/environments/dev/terraform.tfvars
```

Review plan carefully before applying.

#### 3. Deploy Infrastructure

```bash
npm run terraform:apply -- -var-file=infra/environments/dev/terraform.tfvars
```

#### 4. Deploy Backend

```bash
npm run deploy:dev
```

#### 5. Deploy Frontend

```bash
cd apps/frontend
npm run build

# Upload to S3
aws s3 sync dist/ s3://your-frontend-bucket/
```

### Automated Deployment (GitHub Actions)

Push to branch triggers automated deployment:

```bash
# Deploy to dev
git push origin develop

# Deploy to staging
git push origin main

# Deploy to production
# Create release on GitHub
# Release triggers automatic production deployment
```

## Monitoring Deployments

### Check Deployment Status

```bash
# Lambda functions
aws lambda list-functions

# DynamoDB tables
aws dynamodb list-tables

# API Gateway
aws apigateway get-rest-apis
```

### View Logs

```bash
# CloudWatch logs
aws logs tail /aws/lambda/serverless-mern-getUser --follow

# Lambda metrics
aws cloudwatch get-metric-statistics \
  --metric-name Invocations \
  --namespace AWS/Lambda \
  --start-time 2024-01-01T00:00:00Z \
  --end-time 2024-01-02T00:00:00Z
```

## Rollback Procedures

### Rollback Infrastructure

```bash
# Get previous Terraform state
aws s3 cp s3://serverless-mern-terraform-state-dev/dev/terraform.tfstate ./previous.tfstate

# Restore and apply
terraform apply -state=previous.tfstate
```

### Rollback Deployment

```bash
# Update Lambda code to previous version
aws lambda update-function-code \
  --function-name serverless-mern-getUser \
  --s3-bucket deployment-bucket \
  --s3-key previous-version.zip
```

## Production Checklist

- [ ] All tests pass
- [ ] Code review approved
- [ ] Terraform plan reviewed
- [ ] Backups configured
- [ ] Monitoring and alarms set up
- [ ] Incident runbook prepared
- [ ] Team notified
- [ ] Deployment window scheduled

## Post-Deployment

### Smoke Tests

```bash
# Health check
curl https://api.example.com/health

# API test
curl https://api.example.com/users

# Frontend load
curl https://example.com
```

### Data Validation

```bash
# Check DynamoDB
aws dynamodb scan --table-name users-prod

# Verify SES configuration
aws ses verify-email-identity \
  --email-address noreply@example.com
```

## Troubleshooting

### Deployment Fails

1. Check CloudFormation events:
```bash
aws cloudformation describe-stack-events \
  --stack-name serverless-mern
```

2. Review Lambda logs:
```bash
aws logs tail /aws/lambda/ --follow --since 10m
```

3. Verify IAM permissions

### Lambda Timeout

Increase timeout in `serverless.yml`:
```yaml
functions:
  getUser:
    handler: src/domains/users/handlers/getUser.handler
    timeout: 60  # Increase from 30
```

## Disaster Recovery

### Database Recovery

```bash
# Export DynamoDB data
aws dynamodb export-table-to-point-in-time \
  --table-arn arn:aws:dynamodb:us-east-1:123456789012:table/users \
  --s3-bucket recovery-bucket

# Restore from backup
aws dynamodb restore-table-from-backup \
  --target-table-name users-restored \
  --backup-arn arn:aws:dynamodb:us-east-1:123456789012:table/users/backup/123
```

### Code Recovery

```bash
# Revert to previous git tag
git checkout v1.0.0
npm run deploy:prod
```

## Cost Optimization

### Monitor Costs

```bash
# Get cost breakdown
aws ce get-cost-and-usage \
  --time-period Start=2024-01-01,End=2024-01-31 \
  --granularity MONTHLY \
  --metrics "UnblendedCost"
```

### Reduce Costs

- Use DynamoDB on-demand for variable loads
- Set Lambda memory to minimum viable
- Use S3 lifecycle policies for old objects
- Clean up unused resources regularly
