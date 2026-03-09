module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/src', '<rootDir>/tests'],
  testMatch: ['**/__tests__/**/*.ts', '**/?(*.)+(spec|test).ts'],
  moduleFileExtensions: ['ts', 'tsx', 'js', 'jsx', 'json', 'node'],
  collectCoverageFrom: [
    'src/**/*.ts',
    '!src/**/*.d.ts',
    '!src/**/index.ts'
  ],
  coverageThreshold: {
    global: {
      branches: 70,
      functions: 70,
      lines: 70,
      statements: 70
    }
  },
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1',
    '^@serverless-mern/types$': '<rootDir>/../../packages/types/src',
    '^@serverless-mern/logger$': '<rootDir>/../../packages/logger/src',
    '^@serverless-mern/validators$': '<rootDir>/../../packages/validators/src',
    '^@serverless-mern/aws-sdk$': '<rootDir>/../../packages/aws-sdk/src'
  }
};
