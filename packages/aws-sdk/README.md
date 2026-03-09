# AWS SDK Package

Wrapped AWS SDK clients with retry logic and error handling.

## Features

- **DynamoDB client** with connection pooling
- **S3 client** for file operations
- **EventBridge client** for event publishing
- **SES client** for email sending
- **Automatic retries** with exponential backoff
- **Error handling** with custom exceptions

## Installation

Already included in monorepo workspaces.

## Usage

### DynamoDB

```typescript
import { getDynamoDBClient, getItem, putItem } from '@serverless-mern/aws-sdk';

// Get item
const user = await getItem({
  TableName: 'users-dev',
  Key: { id: { S: 'user-123' } }
});

// Put item
await putItem({
  TableName: 'users-dev',
  Item: {
    id: { S: 'user-123' },
    email: { S: 'user@example.com' },
    createdAt: { S: new Date().toISOString() }
  }
});
```

### S3

```typescript
import { uploadFile, downloadFile, deleteFile } from '@serverless-mern/aws-sdk';

// Upload
const key = await uploadFile({
  bucket: 'uploads-bucket',
  key: 'profile-123.jpg',
  body: fileBuffer,
  contentType: 'image/jpeg'
});

// Download
const data = await downloadFile({
  bucket: 'uploads-bucket',
  key: 'profile-123.jpg'
});

// Delete
await deleteFile({
  bucket: 'uploads-bucket',
  key: 'profile-123.jpg'
});
```

### EventBridge

```typescript
import { publishEvent } from '@serverless-mern/aws-sdk';

await publishEvent({
  source: 'serverless-mern.users',
  detailType: 'user.created',
  detail: {
    userId: 'user-123',
    email: 'user@example.com'
  }
});
```

### SES Email

```typescript
import { sendEmail } from '@serverless-mern/aws-sdk';

await sendEmail({
  to: 'recipient@example.com',
  subject: 'Welcome!',
  htmlBody: '<h1>Welcome to our app</h1>',
  textBody: 'Welcome to our app'
});
```

## Error Handling

Automatic retries with exponential backoff:

```typescript
try {
  await getItem(params);
} catch (error) {
  // After 3 retries with exponential backoff
  logger.error('DynamoDB operation failed', error);
  // Handle error
}
```

## Configuration

Via environment variables:

```bash
AWS_REGION=us-east-1
AWS_ACCESS_KEY_ID=your-key
AWS_SECRET_ACCESS_KEY=your-secret
LOCALSTACK_ENDPOINT=http://localhost:4566  # For local dev
```

## LocalStack Support

Automatically detects LocalStack endpoint:

```bash
# Local development
LOCALSTACK_ENDPOINT=http://localhost:4566 npm run dev

# AWS (production)
npm run deploy:prod
```

## Performance

- Connection pooling
- Request batching where applicable
- Minimal memory footprint
- Efficient payload serialization

See [Contributing Guide](../../docs/CONTRIBUTING.md).
