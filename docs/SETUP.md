# Setup Guide

## Prerequisites

- Node.js 18+ ([install](https://nodejs.org))
- npm 9+ (comes with Node.js)
- Docker Desktop ([install](https://www.docker.com/products/docker-desktop))
- AWS CLI v2 ([install](https://aws.amazon.com/cli/))
- Terraform 1.0+ ([install](https://www.terraform.io/downloads))
- Git

## Initial Setup

### 1. Clone and Install

```bash
git clone <repo>
cd serverless-mern-monorepo
npm install
```

### 2. Environment Configuration

```bash
cp .env.example .env.dev
```

Edit `.env.dev` with your values:
```bash
APP_ENVIRONMENT=dev
AWS_REGION=us-east-1
DYNAMODB_USERS_TABLE=users-dev
LOG_LEVEL=info
```

### 3. AWS Credentials

Configure AWS CLI:
```bash
aws configure
# Or set environment variables:
export AWS_ACCESS_KEY_ID=your_key
export AWS_SECRET_ACCESS_KEY=your_secret
export AWS_REGION=us-east-1
```

### 4. Install Global Tools

```bash
npm install -g serverless terraform
```

## Local Development

### Start LocalStack + Backend + Frontend

```bash
npm run local-dev
```

This starts:
- **LocalStack**: http://localhost:4566
- **Frontend**: http://localhost:3000
- **Backend**: http://localhost:3001

### Backend Development Only

```bash
cd apps/backend
npm run dev
```

### Frontend Development Only

```bash
cd apps/frontend
npm run dev
```

### Database Seeding

Initialize test data:
```bash
bash scripts/seed-db.sh
```

## Running Tests

### All Tests
```bash
npm test
```

### Watch Mode
```bash
npm run test:watch
```

### Coverage
```bash
npm run test:coverage
```

### Specific Package
```bash
npm run test --workspace=@serverless-mern/backend
```

## Linting and Formatting

### Lint Code
```bash
npm run lint
npm run lint:fix
```

### Format Code
```bash
npm run format
```

## Deployment

### Development

```bash
npm run deploy:dev
```

### Staging

```bash
npm run deploy:staging
```

### Production

```bash
npm run deploy:prod
```

## Infrastructure

### Initialize Terraform

```bash
npm run terraform:init
```

### Plan Infrastructure Changes

```bash
npm run terraform:plan
```

### Apply Infrastructure

```bash
npm run terraform:apply
```

## Troubleshooting

### Docker Issues

**Containers won't start**
```bash
docker-compose -f docker/docker-compose.local.yml down --volumes
docker-compose -f docker/docker-compose.local.yml up -d
```

### LocalStack Issues

**Can't connect to AWS services**
```bash
# Test LocalStack
aws --endpoint-url=http://localhost:4566 s3 ls

# Check logs
docker logs localstack_localstack_1
```

### Build Failures

**Clear build cache**
```bash
npm run clean
npm install
npm run build
```

## Next Steps

1. Read [ARCHITECTURE.md](./ARCHITECTURE.md) for system design
2. Check [API.md](./API.md) for API documentation
3. Review [DEPLOYMENT.md](./DEPLOYMENT.md) for production setup
4. See [LOCAL_DEVELOPMENT.md](./LOCAL_DEVELOPMENT.md) for advanced local setup
