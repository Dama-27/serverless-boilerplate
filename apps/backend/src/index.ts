/**
 * Backend application entry point
 */

export const handler = async () => {
  return {
    statusCode: 200,
    body: JSON.stringify({ message: 'Welcome to Serverless MERN API' })
  };
};
