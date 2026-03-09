/**
 * DynamoDB table names
 */

import { config } from '@/config/app.config';

export const TABLE_NAMES = {
  USERS: config.aws.dynamodb.tables.users,
  ORDERS: config.aws.dynamodb.tables.orders,
  NOTIFICATIONS: config.aws.dynamodb.tables.notifications
};
