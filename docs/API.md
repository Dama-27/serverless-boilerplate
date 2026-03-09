# Architecture & Infrastructure Documentation

## System Design

```
End User
    ↓
Frontend (React, TypeScript)
    ↓
Cognito Authentication
    ↓
API Gateway (REST)
    ↓
Lambda Functions
    ├─ User Domain
    ├─ Order Domain
    └─ Notification Domain
    ↓
DynamoDB (Data)
    ↓
EventBridge
    ↓
Async Handlers
    ├─ SES (Email)
    └─ S3 (Storage)
```

## Quick Links

- [Setup Guide](./SETUP.md) - Getting started
- [Local Development](./LOCAL_DEVELOPMENT.md) - Development environment
- [Deployment Guide](./DEPLOYMENT.md) - Production deployment
- [Contributing Guide](./CONTRIBUTING.md) - Code standards

## Key Technologies

Backend
- AWS Lambda - Compute
- API Gateway - HTTP API
- DynamoDB - NoSQL database
- EventBridge - Event bus
- SES - Email service
- S3 - File storage

Infrastructure
- Terraform - Infrastructure as Code
- AWS CloudFormation - Resource provisioning
- GitHub Actions - CI/CD

Frontend
- React 18 - UI framework
- TypeScript - Type safety
- Vite - Build tool

Shared
- Joi - Validation
- Winston/Pino - Logging

## Project Layout

```
├── apps/backend     - Lambda functions & API
├── apps/frontend    - React application
├── packages/        - Shared libraries
├── infra/          - Terraform modules
├── scripts/        - Automation
├── docker/         - Container setup
└── docs/           - Documentation
```

## Getting Help

1. Check relevant documentation file
2. Search GitHub issues
3. Review code comments and types
4. Create new GitHub issue
