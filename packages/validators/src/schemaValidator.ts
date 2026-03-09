/**
 * Schema validator using Joi
 */

import Joi from 'joi';

export interface ValidationResult<T> {
  valid: boolean;
  data?: T;
  error?: any;
}

export class SchemaValidator {
  static validate<T>(data: any, schema: Joi.Schema): ValidationResult<T> {
    const { error, value } = schema.validate(data, {
      abortEarly: false,
      stripUnknown: true
    });

    if (error) {
      return {
        valid: false,
        error: error.details.map(detail => ({
          field: detail.path.join('.'),
          message: detail.message
        }))
      };
    }

    return {
      valid: true,
      data: value as T
    };
  }
}

export default SchemaValidator;
