/**
 * Lambda handler for getting an order
 */

import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';

export const handler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
  try {
    const { id } = event.pathParameters || {};

    if (!id) {
      return {
        statusCode: 400,
        body: JSON.stringify({ error: 'Order ID is required' })
      };
    }

    // TODO: Implement get order logic

    return {
      statusCode: 200,
      body: JSON.stringify({ message: `Get order ${id}` })
    };
  } catch (error) {
    console.error('Error getting order:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Internal server error' })
    };
  }
};
