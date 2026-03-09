# Local Development Guide

## Quick Start

```bash
npm run local-dev
```

This command:
1. Starts LocalStack (AWS simulation)
2. Creates DynamoDB tables
3. Starts backend Lambda emulation
4. Starts frontend dev server
5. Initializes sample data

Services will be available at:
- Frontend: http://localhost:3000
- Backend: http://localhost:3001
- LocalStack: http://localhost:4566

## Understanding LocalStack

LocalStack simulates AWS services locally for development and testing.

### Creating Resources

```bash
# Create DynamoDB table
aws --endpoint-url=http://localhost:4566 \
  dynamodb create-table \
  --table-name users-dev \
  --attribute-definitions AttributeName=id,AttributeType=S \
  --key-schema AttributeName=id,KeyType=HASH \
  --billing-mode PAY_PER_REQUEST \
  --region us-east-1
```

### Querying Resources

```bash
# List DynamoDB tables
aws --endpoint-url=http://localhost:4566 \
  dynamodb list-tables --region us-east-1

# Get item from table
aws --endpoint-url=http://localhost:4566 \
  dynamodb get-item \
  --table-name users-dev \
  --key '{"id":{"S":"user-1"}}' \
  --region us-east-1
```

## Backend Development

### Start Only Backend

```bash
cd apps/backend
npm run dev
```

The Lambda local emulator will start at `http://localhost:3001`.

### Test Lambda Functions Locally

```bash
# Via serverless
serverless invoke local --function getUser --stage dev

# Via Lambda URL
curl http://localhost:3001/users/user-1
```

### Environment Variables

Update `apps/backend/.env`:
```bash
AWS_REGION=us-east-1
LOCALSTACK_ENDPOINT=http://localhost:4566
DYNAMODB_USERS_TABLE=users-dev
LOG_LEVEL=debug
```

### Debug Lambda Functions

Add debug logging:
```typescript
import { Logger } from '@serverless-mern/logger'

const logger = Logger.getInstance('debug')

export const handler = async (event) => {
  logger.debug('Handler invoked', { event })
  // Your code here
}
```

View logs:
```bash
# Docker logs
docker logs serverless-mern-backend-1

# Or watch logs
docker logs -f serverless-mern-backend-1
```

## Frontend Development

### Start Only Frontend

```bash
cd apps/frontend
npm run dev
```

The Vite dev server will start at `http://localhost:3000`.

### API Integration

Frontend calls backend through Axios:
```typescript
// services/api.ts
const api = axios.create({
  baseURL: process.env.REACT_APP_API_URL || 'http://localhost:3001'
})
```

### Environment Variables

Update `apps/frontend/.env`:
```bash
REACT_APP_API_URL=http://localhost:3001
REACT_APP_LOG_LEVEL=debug
```

### Hot Module Replacement (HMR)

Changes automatically reload in the browser.

## Database Development

### View DynamoDB Data

```bash
# Install NoSQL Workbench or use AWS CLI
aws --endpoint-url=http://localhost:4566 \
  dynamodb scan \
  --table-name users-dev \
  --region us-east-1
```

### Seed Test Data

```bash
bash scripts/seed-db.sh
```

### Reset Database

```bash
# Stop and remove LocalStack container
docker-compose -f docker/docker-compose.local.yml down

# Remove volume
docker volume rm localstack_localstack_data

# Restart
docker-compose -f docker/docker-compose.local.yml up -d
```

## Testing During Development

### Watch Mode

```bash
npm run test:watch
```

Tests automatically rerun when files change.

### Test Specific Package

```bash
npm run test:watch --workspace=@serverless-mern/backend
```

### Coverage Report

```bash
npm run test:coverage
open coverage/lcov-report/index.html
```

## Debugging

### VS Code Debugging

1. Add `.vscode/launch.json`:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "attach",
      "name": "Attach Backend",
      "port": 9229,
      "skipFiles": ["<node_internals>/**"]
    }
  ]
}
```

2. Start backend with debugging:
```bash
node --inspect-brk node_modules/.bin/serverless offline start
```

### Browser DevTools

Frontend: Use Chrome DevTools (F12)
- Network: API calls
- Console: Logs and errors
- Sources: Step through code

## Performance Testing

### Load Testing

```bash
# Using Apache Bench
ab -n 1000 -c 10 http://localhost:3001/users

# Using Apache JMeter or similar tools
```

### Memory Profiling

```bash
# Start backend with profiler
node --prof node_modules/.bin/serverless offline start

# Analyze profile
node --prof-process isolate-*.log > profile.txt
```

## Common Issues

### Port Already in Use

```bash
# Find process using port 3000
lsof -i :3000

# Kill process
kill -9 <PID>
```

### LocalStack Connection Issues

```bash
# Verify LocalStack is running
docker ps | grep localstack

# Check logs
docker logs localstack_localstack_1

# Verify endpoint
curl http://localhost:4566/_localstack/health
```

### Build Failures

```bash
# Clear TypeScript cache
find . -name "dist" -type d -exec rm -rf {} + 2>/dev/null

# Rebuild
npm run build
```

## Tips & Tricks

### Quick Environment Switch

```bash
# Copy test environment
cp .env.example .env.test

# Load in CLI
set -a; source .env.test; set +a
```

### Database Inspection

```bash
# Export table to JSON
aws --endpoint-url=http://localhost:4566 \
  dynamodb scan \
  --table-name users-dev \
  --region us-east-1 \
  | jq '.Items' > backup.json
```

### Monitoring Logs

```bash
# Tail all Docker logs
docker-compose -f docker/docker-compose.local.yml logs --follow

# Tail specific service
docker-compose -f docker/docker-compose.local.yml logs --follow backend
```
