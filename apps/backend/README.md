# Serverless MERN Backend README

## Overview

Lambda-based backend for serverless MERN application built with AWS Lambda, API Gateway, DynamoDB, and EventBridge.

## Structure

```
src/
  ├── domains/          # Business domains
  │   ├── users/
  │   ├── orders/
  │   └── notifications/
  ├── shared/           # Shared utilities
  │   ├── middleware/
  │   ├── utils/
  │   ├── lib/
  │   ├── constants/
  │   ├── types/
  │   └── decorators/
  ├── events/           # Event handling
  ├── config/           # Configuration
  └── index.ts          # Entry point
```

## Development

### Install Dependencies
```bash
npm install
```

### Start Local Development
```bash
npm run dev
```

Starts Lambda local emulation at `http://localhost:3000`

### Build
```bash
npm run build
```

### Test
```bash
npm run test
npm run test:watch
```

### Lint
```bash
npm run lint
npm run lint:fix
```

## Deployment

### Deploy to Dev
```bash
npm run deploy:dev
```

### Deploy to Staging
```bash
npm run deploy:staging
```

### Deploy to Production
```bash
npm run deploy:prod
```

## API Endpoints

### Users Domain
- `GET /users/{id}` - Get user
- `POST /users` - Create user
- `PUT /users/{id}` - Update user
- `DELETE /users/{id}` - Delete user

### Orders Domain
- `GET /orders/{id}` - Get order
- `POST /orders` - Create order
- `PUT /orders/{id}` - Update order

## Environment Variables

See `.env.example` for all available variables.

Key variables:
- `DYNAMODB_USERS_TABLE` - Users table name
- `DYNAMODB_ORDERS_TABLE` - Orders table name
- `EVENT_BUS_NAME` - EventBridge bus name
- `LOG_LEVEL` - Logging level (debug, info, warn, error)

## Adding New Features

### 1. Create Domain

```bash
mkdir -p src/domains/feature/{handlers,services,repositories,types}
```

### 2. Add Types

```typescript
// src/domains/feature/types/feature.types.ts
export interface Feature {
  id: string;
  name: string;
}
```

### 3. Add Service

```typescript
// src/domains/feature/services/featureService.ts
export class FeatureService {
  async getFeature(id: string): Promise<Feature> {
    // Implementation
  }
}
```

### 4. Add Handler

Update `serverless.yml`:
```yaml
functions:
  getFeature:
    handler: src/domains/feature/handlers/getFeature.handler
    events:
      - http:
          path: features/{id}
          method: get
          cors: true
```

Create handler:
```typescript
// src/domains/feature/handlers/getFeature.handler.ts
export const handler = async (event: APIGatewayProxyEvent) => {
  // Implementation
};
```

### 5. Add Tests

```typescript
// src/domains/feature/__tests__/featureService.test.ts
describe('FeatureService', () => {
  // Tests
});
```

## Event-Driven Features

### Publishing Events

```typescript
import { eventBus } from '@/shared/lib/eventBus';

await eventBus.publish('feature.created', {
  featureId: feature.id,
  name: feature.name,
  timestamp: new Date()
});
```

### Handling Events

Create event handler function and add to `serverless.yml`:
```yaml
functions:
  featureCreatedHandler:
    handler: src/events/eventHandlers/featureCreatedHandler.handler
    events:
      - eventBridge:
          eventBus: ${self:custom.eventBusName}
          pattern:
            source:
              - serverless-mern.features
            detail-type:
              - feature.created
```

## Logging

Use the structured logger:

```typescript
import { Logger } from '@serverless-mern/logger';

const logger = Logger.getInstance();

logger.info('Processing request', { requestId: 'abc123' });
logger.error('An error occurred', error, { context: 'userCreation' });
```

## Error Handling

Throw custom errors:

```typescript
import { BadRequest, NotFound } from '@/shared/errors';

if (!user) {
  throw new NotFound('User not found');
}

throw new BadRequest('Invalid input data');
```

## Database Operations

Use DynamoDB utilities:

```typescript
import { getDynamoDBClient } from '@serverless-mern/aws-sdk';

const client = getDynamoDBClient();

// Get item
const item = await client.send(new GetCommand(params));

// Query items
const result = await client.send(new QueryCommand(params));
```

## Testing

### Unit Tests

Test business logic in isolation:

```typescript
describe('UserService', () => {
  it('should create a user', async () => {
    const service = new UserService(mockRepository);
    const user = await service.createUser({...});
    expect(user.email).toBe('test@example.com');
  });
});
```

### Integration Tests

Test with LocalStack:

```typescript
describe('User Handler', () => {
  it('should handle GET /users/{id}', async () => {
    const event = {
      pathParameters: { id: 'user-1' }
    };
    const response = await handler(event);
    expect(response.statusCode).toBe(200);
  });
});
```

See [Contributing Guide](../../docs/CONTRIBUTING.md) for more details.
