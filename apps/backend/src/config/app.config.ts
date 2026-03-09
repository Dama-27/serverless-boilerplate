/**
 * Environment variables and application configuration
 */

export const config = {
  environment: process.env.APP_ENVIRONMENT || 'dev',
  nodeEnv: process.env.NODE_ENV || 'development',
  logLevel: process.env.LOG_LEVEL || 'info',

  aws: {
    region: process.env.AWS_REGION || 'us-east-1',
    dynamodb: {
      tables: {
        users: process.env.DYNAMODB_USERS_TABLE || 'users-dev',
        orders: process.env.DYNAMODB_ORDERS_TABLE || 'orders-dev',
        notifications: process.env.DYNAMODB_NOTIFICATIONS_TABLE || 'notifications-dev'
      }
    },
    eventBridge: {
      busName: process.env.EVENT_BUS_NAME || 'serverless-mern-dev'
    },
    s3: {
      uploadsBucket: process.env.S3_UPLOADS_BUCKET || 'serverless-mern-uploads-dev'
    },
    cognito: {
      userPoolId: process.env.COGNITO_USER_POOL_ID || ''
    }
  },

  api: {
    stage: process.env.API_STAGE || 'dev',
    timeout: parseInt(process.env.LAMBDA_TIMEOUT || '30', 10)
  }
};

export type Config = typeof config;
