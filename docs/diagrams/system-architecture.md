# Architecture Diagrams

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         Users                                   │
└────────────────┬─────────────────────────────┬──────────────────┘
                 │                             │
          ┌──────▼──────┐            ┌────────▼─────────┐
          │   Web App   │            │   Mobile App     │
          │ (React SPA) │            │  (React Native)  │
          └──────┬──────┘            └────────┬─────────┘
                 │                             │
                 └──────────────┬──────────────┘
                                │
                     ┌──────────▼──────────┐
                     │  CloudFront CDN    │
                     │ (Static Assets)    │
                     └──────────┬─────────┘
                                │
                     ┌──────────▼──────────┐
                     │  Cognito Auth      │
                     │  (User Pools)      │
                     └──────────┬─────────┘
                                │
                     ┌──────────▼──────────┐
                     │  API Gateway       │
                     │  (REST + CORS)     │
                     └──────────┬─────────┘
                                │
                ┌───────────────┼───────────────┐
                ▼               ▼               ▼
         ┌──────────────┐ ┌──────────────┐ ┌──────────────┐
         │ Lambda:      │ │ Lambda:      │ │ Lambda:      │
         │  Users       │ │  Orders      │ │ Notifications
         │  Domain      │ │  Domain      │ │  Domain     │
         └──────┬───────┘ └────┬─────────┘ └──────┬───────┘
                │              │                  │
                └──────────────┬──────────────────┘
                               │
                    ┌──────────▼────────────┐
                    │   DynamoDB Tables    │
                    │  users, orders, etc  │
                    └──────────┬───────────┘
                               │
        ┌──────────────────────┼──────────────────────┐
        │                      │                      │
        ▼                      ▼                      ▼
    ┌────────────┐      ┌─────────────┐      ┌──────────────┐
    │ EventBridge│      │    S3       │      │   SES        │
    │  Event Bus │      │  Storage    │      │   Email      │
    └──────┬─────┘      └─────────────┘      └──────────────┘
           │
    ┌──────▼────────────┐
    │ Event Handlers    │
    │  (Async Tasks)    │
    └───────────────────┘
           │
    ┌──────▼────────────────────┐
    │ SQS / SNS / Other Services │
    └───────────────────────────┘
```

## Deployment Pipeline

```
Developer Commit
    ↓
GitHub Webhook
    ↓
GitHub Actions
    ├─ Lint & Format Check
    ├─ Unit Tests
    ├─ Integration Tests
    ├─ Build Docker Images
    ├─ Security Scan
    └─ Push to Registry
        ↓
Terraform Plan
    └─ Review Infrastructure Changes
        ↓
Approval Required (Staging/Prod)
    ↓
Terraform Apply
    └─ Provision AWS Resources
        ↓
Lambda Deployment
    └─ Update Function Code
        ↓
Database Migrations
    └─ Update Schema
        ↓
Health Checks
    └─ Verify Deployment
        ↓
Rollback Plan Ready
    └─ Quick Revert if Issues
```

## Data Flow: User Creation

```
Frontend                 API Gateway              Lambda                DynamoDB
   │                          │                     │                      │
   ├─ POST /users ────────────>                     │                      │
   │                          │                     │                      │
   │                          ├─ Authorize ───────>                        │
   │                          │  (Cognito)          │                      │
   │                          │  <─────────────────┤                       │
   │                          │                     │                      │
   │                          ├─ Route to Lambda ──>│                      │
   │                          │                     ├─ Validate Schema     │
   │                          │                     ├─ Check Duplicate ───>
   │                          │                     │  <──────────────────│
   │                          │                     ├─ Create User ──────>
   │                          │                     │  <──────────────────│
   │                          │                     ├─ Publish Event      │
   │                          │  <───────────────────┤ (EventBridge)       │
   │  <───────────────────────┤                     │                      │
   │  201 Created             │                     │                      │
   │                          │                     │                      │
   
   [Async Event Processing]
   
   EventBridge Rule Triggered
         │
         ├─ user.created event
         │
         ├─ Route to handlers
         │  ├─ Send Welcome Email (SES)
         │  ├─ Create User Preferences
         │  └─ Log Analytics Event
```

## Environment Separation

```
Development
├─ LocalStack (Mock AWS)
├─ DynamoDB Local
├─ Serverless Offline
└─ Hot Reload

Staging
├─ Real AWS (us-east-1)
├─ RDS (Optional)
├─ ElastiCache (Optional)
├─ CloudFront (Optional)
└─ Same Services as Prod

Production
├─ Multi-Region Support
├─ High Availability
├─ Auto-Scaling
├─ Backup & Disaster Recovery
├─ Enhanced Monitoring
└─ Compliance & Security
```

## Monitoring & Observability

```
                        CloudWatch
                            │
        ┌───────────────────┼───────────────────┐
        │                   │                   │
        ▼                   ▼                   ▼
    CloudWatch           CloudWatch            X-Ray
    Logs                 Metrics               (Tracing)
    │                   │
    ├─ Lambda Logs      ├─ Lambda Duration
    ├─ API Logs         ├─ Error Rate
    ├─ DynamoDB Logs    ├─ Throttling
    └─ App Logs         └─ Custom Metrics
                            │
                    ┌───────┴────────┐
                    │                │
                    ▼                ▼
            CloudWatch Alarms    SNS → Slack
            │                        │
            ├─ High Error Rate       └─ Notifications
            ├─ Timeout               
            ├─ Throttling            
            └─ Latency              
```
