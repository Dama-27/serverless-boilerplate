/**
 * API types shared across backend and frontend
 */

export interface ApiResponse<T = any> {
  data?: T;
  error?: string;
  message?: string;
  statusCode: number;
}

export interface ApiError {
  code: string;
  message: string;
  details?: Record<string, any>;
}

export interface PaginatedResponse<T> {
  items: T[];
  total: number;
  page: number;
  pageSize: number;
}
