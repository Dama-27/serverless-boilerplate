# Logger Package

Structured logging library for CloudWatch integration.

## Features

- **Structured JSON logging** for CloudWatch parsing
- **Multiple log levels**: debug, info, warn, error
- **Context tracking**: Request IDs, User IDs, Trace IDs
- **Singleton pattern** for consistent logger instances
- **Performance**: Minimal overhead

## Installation

Already included in monorepo workspaces.

## Usage

### Basic Logging

```typescript
import { Logger } from '@serverless-mern/logger';

const logger = Logger.getInstance();

logger.info('User created', { userId: 'user-123' });
logger.warn('High latency detected', { duration: 5000 });
logger.error('Database connection failed', error, { retries: 3 });
```

### With Lambda Handlers

```typescript
const logger = Logger.getInstance();

export const handler = async (event) => {
  logger.info('Lambda invoked', {
    requestId: event.requestContext?.requestId,
    path: event.path
  });
  
  try {
    // ... handler logic
  } catch (error) {
    logger.error('Handler error', error, { event });
    throw error;
  }
};
```

### Setting Log Level

```bash
# Via environment
LOG_LEVEL=debug npm run dev

# Via code
const logger = Logger.getInstance('debug');
```

## Log Output

Logs are output as structured JSON:

```json
{
  "timestamp": "2024-01-15T10:30:45.123Z",
  "level": "info",
  "message": "User created",
  "userId": "user-123"
}
```

## CloudWatch Integration

Logs automatically appear in CloudWatch Logs:
```
/aws/lambda/serverless-mern-*
```

Query logs:
```bash
aws logs filter-log-events \
  --log-group-name /aws/lambda/serverless-mern-getUser
```

## Performance

Minimal overhead:
- Single-line JSON output
- No network calls from logger
- Async-safe

See [Contributing Guide](../../docs/CONTRIBUTING.md).
