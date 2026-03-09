# Shared Types Package

Centralized TypeScript types and interfaces used across the monorepo.

## Exports

### API Types
```typescript
import { ApiResponse, ApiError, PaginatedResponse } from '@serverless-mern/types';
```

### Domain Types
```typescript
import { User, Order, Notification } from '@serverless-mern/types';
```

### Event Types
```typescript
import { UserCreatedEvent, OrderCompletedEvent } from '@serverless-mern/types';
```

## Usage

```typescript
import type { ApiResponse, User } from '@serverless-mern/types';

const response: ApiResponse<User> = {
  data: user,
  statusCode: 200
};
```

## Adding Types

1. Create file in `src/`
2. Export types from `src/index.ts`
3. Use in backend and frontend

Example:
```typescript
// src/payment.types.ts
export interface Payment {
  id: string;
  amount: number;
  status: 'pending' | 'completed' | 'failed';
}
```

See [Contributing Guide](../../docs/CONTRIBUTING.md).
