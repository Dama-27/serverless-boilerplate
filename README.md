# Serverless MERN Monorepo

A production-ready monorepo for building scalable serverless applications using AWS Lambda, DynamoDB, and React.

## 🏗️ Architecture

This monorepo follows a modular, domain-driven design with:
- **Backend**: Event-driven microservices using AWS Lambda
- **Frontend**: React application with TypeScript
- **Infrastructure**: Terraform modules for AWS resource management
- **Shared Packages**: Reusable TypeScript libraries

## 📁 Project Structure

```
.
├── apps/
│   ├── backend/       # Lambda functions, API Gateway
│   └── frontend/      # React TypeScript application
├── packages/          # Shared TypeScript libraries
│   ├── types/         # Shared type definitions
│   ├── logger/        # Structured logging
│   ├── validators/    # Input validation schemas
│   └── aws-sdk/       # AWS SDK wrappers
├── infra/             # Terraform Infrastructure as Code
├── scripts/           # Automation and setup scripts
└── docker/            # Docker compose configurations
```

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ and npm 9+
- Docker Desktop (for LocalStack and local development)
- AWS CLI configured with credentials
- Terraform 1.0+

### Setup
```bash
# Install dependencies
npm install

# Setup environment
cp .env.example .env.dev
npm run local-dev
```

### Development

**Backend (Lambda development)**
```bash
cd apps/backend
npm run dev
```

**Frontend (React development)**
```bash
cd apps/frontend
npm run dev
```

**Run tests**
```bash
npm run test
npm run test:watch
```

**Linting and formatting**
```bash
npm run lint
npm run format
```

## 🌐 Deployment

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

### Infrastructure
```bash
# Initialize Terraform
npm run terraform:init

# Plan infrastructure changes
npm run terraform:plan

# Apply infrastructure
npm run terraform:apply
```

## 📦 Shared Packages

### @monorepo/types
Shared TypeScript interfaces and types used across the application.

### @monorepo/logger
Structured logging with CloudWatch integration.

### @monorepo/validators
Input validation using Joi/Zod schemas.

### @monorepo/aws-sdk
AWS SDK client wrappers with retry logic and error handling.

## 🗂️ Key Features

- ✅ **Domain-Driven Design**: Organized by business domains (users, orders, etc.)
- ✅ **Event-Driven Architecture**: EventBridge for async communication
- ✅ **Infrastructure as Code**: Complete AWS setup with Terraform
- ✅ **Local Development**: LocalStack support for AWS simulation
- ✅ **Monorepo**: Single repository with multiple apps and packages
- ✅ **Type Safety**: Full TypeScript with strict mode
- ✅ **Testing**: Unit and integration test structure
- ✅ **CI/CD**: GitHub Actions workflows

## 📚 Documentation

- [Architecture](docs/ARCHITECTURE.md)
- [Setup Guide](docs/SETUP.md)
- [API Documentation](docs/API.md)
- [Deployment Guide](docs/DEPLOYMENT.md)
- [Local Development](docs/LOCAL_DEVELOPMENT.md)
- [Contributing](docs/CONTRIBUTING.md)

## 🔐 Security

- Cognito authentication for users
- IAM least privilege for Lambda functions
- VPC isolation for database access
- Secrets Manager for sensitive data
- API Gateway request validation

## 📊 Monitoring

- CloudWatch Logs for structured logging
- CloudWatch Metrics for custom metrics
- X-Ray for distributed tracing
- CloudWatch Alarms for critical errors

## 🛠️ Tech Stack

**Backend**
- AWS Lambda (compute)
- API Gateway (HTTP API)
- DynamoDB (database)
- EventBridge (event bus)
- SES (email)
- S3 (file storage)
- Cognito (authentication)
- CloudWatch (monitoring)

**Frontend**
- React 18
- TypeScript
- Redux (state management)
- Axios (HTTP client)
- CSS-in-JS

**Infrastructure**
- Terraform (IaC)
- Docker (containerization)
- LocalStack (local AWS simulation)

**Tools**
- GitHub Actions (CI/CD)
- Jest (testing)
- ESLint (linting)
- Prettier (formatting)

## 📝 License

See [LICENSE](LICENSE) file for details.

## 🤝 Contributing

See [CONTRIBUTING.md](docs/CONTRIBUTING.md) for guidelines.
