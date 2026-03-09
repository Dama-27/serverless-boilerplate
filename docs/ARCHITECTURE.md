# Project Architecture

## System Overview

```
┌─────────────────────────────────────────────────────────────┐
│                        Frontend (React)                      │
│              (Cognito Auth + API Integration)                │
└────────────────────────────┬────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────┐
│                      API Gateway                             │
│                   (REST + CORS)                              │
└────────────────────────────┬────────────────────────────────┘
                             │
                ┌────────────┼────────────┐
                ▼            ▼            ▼
        ┌──────────────┐ ┌────────────┐ ┌──────────────┐
        │  Users       │ │  Orders    │ │ Notifications│
        │  Lambda      │ │  Lambda    │ │  Lambda      │
        │  Functions   │ │  Functions │ │  Functions   │
        └──────┬───────┘ └────┬───────┘ └──────────────┘
               │              │
               ▼              ▼
        ┌──────────────────────────────┐
        │       EventBridge            │
        │   (Event Bus & Rules)         │
        └──────────────┬───────────────┘
                       │
                       ▼
        ┌──────────────────────────────┐
        │    Event Handlers            │
        │  (Service Integration)        │
        └──────────────┬───────────────┘
                       │
        ┌──────────────┴──────────────┐
        │                             │
        ▼                             ▼
   ┌─────────────┐           ┌──────────────┐
   │    DynamoDB │           │   SES Email  │
   │   Tables    │           │  Notifications
   └─────────────┘           └──────────────┘

```

## Components

### Frontend (React)
- **Location**: `apps/frontend`
- **Tech**: React 18, TypeScript, Vite
- **Auth**: Cognito User Pools
- **API Client**: Axios with interceptors
- **State**: Zustand for global state

### Backend (Serverless)
- **Location**: `apps/backend`
- **Framework**: Serverless Framework
- **Compute**: AWS Lambda
- **API**: API Gateway (REST)
- **Database**: DynamoDB
- **Events**: EventBridge

### Domain Structure
Each domain (users, orders, notifications) follows:
```
domains/{domain}/
  ├── handlers/        # Lambda handler functions
  ├── services/        # Business logic
  ├── repositories/    # Data access
  ├── models/          # Data models
  ├── types/           # Domain types
  └── events/          # Domain events
```

### Infrastructure (Terraform)
- **Location**: `infra`
- **Modules**: Reusable AWS resource components
- **Environments**: dev, staging, prod
- **State**: Remote S3 backend

### Shared Packages
```
packages/
  ├── types/           # Shared TypeScript types
  ├── logger/          # Structured logging
  ├── validators/      # Input validation
  └── aws-sdk/         # AWS SDK wrappers
```

## Data Flow

### User Creation Flow
1. Frontend sends POST to `/users`
2. API Gateway routes to `createUser` Lambda
3. Lambda validates input using `@monorepo/validators`
4. Service saves to DynamoDB
5. Service publishes `user.created` event to EventBridge
6. Event handler triggers (notifications, analytics, etc.)

### Event-Driven Architecture
```
Domain Event Published
        ↓
    EventBridge Rule
        ↓
  Target Lambda
        ↓
   Side Effects
   (Email, Cache, etc.)
```

## Security

- **Authentication**: Cognito User Pools
- **Authorization**: IAM roles with least privilege
- **Data**: Encrypted at rest and in transit
- **Secrets**: AWS Secrets Manager
- **API**: Request validation, rate limiting

## Monitoring

- **Logs**: CloudWatch with structured JSON
- **Metrics**: Custom CloudWatch metrics
- **Tracing**: X-Ray for distributed tracing
- **Alarms**: CloudWatch alarms for critical errors

## Scalability Considerations

1. **DynamoDB**: On-demand billing for variable load
2. **Lambda**: Auto-scaling based on concurrency
3. **S3**: Unlimited scalability for static assets
4. **EventBridge**: Decoupled async processing
5. **Caching**: Layer-based caching strategy

## Development Workflow

1. **Local**: LocalStack for AWS simulation
2. **Testing**: Unit + integration tests in CI
3. **Staging**: Full AWS stack for E2E tests
4. **Production**: Blue-green deployment strategy
