/**
 * Event handler for order.completed event
 */

import { EventBridgeEvent } from 'aws-lambda';

interface OrderCompletedDetail {
  orderId: string;
  userId: string;
  completedAt: string;
}

export const handler = async (
  event: EventBridgeEvent<'order.completed', OrderCompletedDetail>
): Promise<void> => {
  try {
    const { detail } = event;
    console.log('Order completed event received:', detail);

    // TODO: Send order confirmation email
    // TODO: Update user notification preferences
    // TODO: Trigger fulfillment process
  } catch (error) {
    console.error('Error handling order.completed event:', error);
    throw error;
  }
};
