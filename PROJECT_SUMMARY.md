# Serverless boilerplate Project Progress Summary

This document is a comprehensive walkthrough and explanation of the work completed on the Serverless MERN monorepo boilerplate to date. It highlights the architectural decisions, the current file structure, and specific code explanations.

## 1. Project Architecture and Structure
The project uses Lerna alongside Yarn Workspaces to organize its code into a monorepo structured logically into applications (`apps/`), shared libraries (`packages/`), and infrastructure configuration (`infra/`).

### Overall Structure
```
serverless-boilerplate/
├── apps/
│   ├── frontend/         # React, Vite, Tailwind CSS (Cognito Auth integrated)
│   └── backend/          # AWS Lambda, API Gateway (Serverless Framework)
├── packages/             # Monorepo Shared Libraries
│   ├── aws-sdk/          # Database connection wrappers
│   ├── logger/           # Shared structured logging utilities
│   ├── types/            # TypeScript schemas and definitions
│   └── validators/       # Input validation tools (Joi)
└── infra/                # Terraform configuration for stateful resources
```

## 2. Infrastructure Deployment Strategy

Initially, the project had conflicting deployment architectures: the Serverless Framework (`apps/backend/serverless.yml`) natively created DynamoDB tables, an Event Bus, and S3 Buckets using CloudFormation, while an `infra/` folder maintained broken dummy Terraform stubs for the same. 

**Recent Cleanup (Option B):**
We implemented an infrastructure separation pattern (also known as the Hybrid strategy):
1. **Stateful Infrastructure via Terraform**: All databases (DynamoDB), events (EventBridge), and object storage (S3) are now fully defined inside `infra/modules/`. Execution commands (`terraform init` & `apply`) at the root `/infra/` directory deploy these independent of the app lifecycle.
2. **Compute via Serverless Framework**: The Backend (`apps/backend/serverless.yml`) manages purely compute logic (Lambda functions and API Gateway endpoints). `serverless.yml` was refactored to construct and reference the ARNs of Terraform-managed databases using `!Sub`.

## 3. Code Explanations & Current Completion Status

The boilerplate has several moving parts. Below explains the progress of these specific parts along with code snippets.

### A. Health Check (Fully Implemented)
A basic, working lambda handler proves out the request-response cycle through API Gateway:
```typescript
// apps/backend/src/domains/health/handlers/lambda-health.handler.ts
export const handler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
  try {
    return {
      statusCode: 200,
      body: JSON.stringify({
        status: 'passed',
        timestamp: new Date().toISOString(),
        message: 'Health check passed'
      })
    };
  } catch (error) { ... }
};
```

### B. Business Domain Setup (In-Progress)
There are multiple handlers scaffolded, such as `createUser`. Currently, these are mocked and act as placeholders for you to fill in business logic:
```typescript
// apps/backend/src/domains/users/handlers/createUser.handler.ts
export const handler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
    const body = event.body ? JSON.parse(event.body) : {};

    // TODO: Validate request body
    // TODO: Implement create user logic

    return { statusCode: 201, body: JSON.stringify({ message: 'User created' }) };
};
```

### C. Shared Validation Layer (Fully Implemented)
The `validators` package offers a reusable wrapper over `joi` logic that correctly unwraps errors into human-readable objects to respond with HTTP 400 Bad Requests:
```typescript
// packages/validators/src/schemaValidator.ts
export class SchemaValidator {
  static validate<T>(data: any, schema: Joi.Schema): ValidationResult<T> {
    const { error, value } = schema.validate(data, { abortEarly: false, stripUnknown: true });
    // ... maps the error and outputs normalized `{ valid: boolean, data?: T, error?: any }` structure
  }
}
```

### D. AWS SDK Wrapper (Stubs, Pending Implementation)
The `aws-sdk` package exports the `getDynamoDBClient` which is instantiated correctly using environment variables (with an override for `LOCALSTACK_ENDPOINT` for local testing).
*Note: The actual CRUD wrappers (`putItem`, `getItem`, `query`, `deleteItem`) are stubbed with `throw new Error('Not implemented');` and require AWS SDK command implementations (e.g. `PutCommand`).*

## 4. Next Steps to Continue Development

1. **Implement CRUD wrappers**: Open `packages/aws-sdk/src/dynamodb.ts` and use the `.send()` command alongside `@aws-sdk/lib-dynamodb` objects to fill out the mocked functions.
2. **Connect Handlers**: Revisit code in `createUser.handler.ts`, utilize the `validators` library to validate payload syntax, and the `aws-sdk` code to save the user row to DynamoDB.
3. **Event Dispatching**: Begin linking User creation occurrences to EventBridge notifications.
