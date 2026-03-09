# Validators Package

Input validation schemas using Joi.

## Features

- **Joi schemas** for type-safe validation
- **Reusable validators** across backend and frontend
- **Error messages** with field-level details
- **Schema composition** for complex types

## Installation

Already included in monorepo workspaces.

## Usage

### Create Schemas

```typescript
import Joi from 'joi';

export const userCreateSchema = Joi.object({
  email: Joi.string().email().required(),
  firstName: Joi.string().max(100).required(),
  lastName: Joi.string().max(100).required(),
  password: Joi.string().min(8).required()
});
```

### Validate Data

```typescript
import { SchemaValidator } from '@serverless-mern/validators';

const result = SchemaValidator.validate(data, userCreateSchema);

if (!result.valid) {
  // Handle validation errors
  result.error.forEach(err => {
    console.log(`${err.field}: ${err.message}`);
  });
} else {
  // Use validated data
  const user = result.data;
}
```

### In Lambda Handlers

```typescript
import { SchemaValidator } from '@serverless-mern/validators';

export const handler = async (event: APIGatewayProxyEvent) => {
  const body = JSON.parse(event.body || '{}');
  
  const validation = SchemaValidator.validate(body, userCreateSchema);
  
  if (!validation.valid) {
    return {
      statusCode: 400,
      body: JSON.stringify({ errors: validation.error })
    };
  }
  
  // Use validated data
  const user = validation.data;
  // ... create user
};
```

## Common Schemas

```typescript
// Email validation
const emailSchema = Joi.string().email().required();

// Password validation
const passwordSchema = Joi.string()
  .min(8)
  .pattern(/[A-Z]/) // uppercase
  .pattern(/[0-9]/) // number
  .required();

// Date validation
const dateSchema = Joi.date().iso().required();

// Enum validation
const statusSchema = Joi.string()
  .valid('pending', 'active', 'archived')
  .required();
```

## Creating Reusable Validators

```typescript
// src/validators/user.validators.ts
import Joi from 'joi';

export const userSchemas = {
  create: Joi.object({
    email: Joi.string().email().required(),
    firstName: Joi.string().required(),
    lastName: Joi.string().required()
  }),
  
  update: Joi.object({
    firstName: Joi.string(),
    lastName: Joi.string()
  }).min(1)
};
```

## Error Handling

Validation errors are structured:

```typescript
{
  valid: false,
  error: [
    { field: 'email', message: '"email" must be a valid email' },
    { field: 'firstName', message: '"firstName" is required' }
  ]
}
```

See [Contributing Guide](../../docs/CONTRIBUTING.md).
