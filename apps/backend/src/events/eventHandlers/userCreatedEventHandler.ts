/**
 * Event handler for user.created event
 */

import { EventBridgeEvent } from 'aws-lambda';

interface UserCreatedDetail {
  userId: string;
  email: string;
  createdAt: string;
}

export const handler = async (
  event: EventBridgeEvent<'user.created', UserCreatedDetail>
): Promise<void> => {
  try {
    const { detail } = event;
    console.log('User created event received:', detail);

    // TODO: Send welcome email
    // TODO: Create user preferences
    // TODO: Initialize analytics record
  } catch (error) {
    console.error('Error handling user.created event:', error);
    throw error;
  }
};
