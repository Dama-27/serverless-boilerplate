# Contributing Guide

## Development Workflow

### 1. Create Feature Branch

```bash
git checkout -b feature/user-authentication
```

### 2. Make Changes

Write code following the project structure and conventions.

### 3. Commit Changes

```bash
git add .
git commit -m "feat: implement user authentication"
```

### 4. Run Tests and Linting

```bash
npm run lint
npm run test
```

### 5. Push and Create PR

```bash
git push origin feature/user-authentication
```

## Code Style

### TypeScript

- Strict mode enabled
- No `any` types (use `unknown` if needed)
- Clear, descriptive variable names
- JSDoc comments for public APIs

### Naming Conventions

```typescript
// ✅ Good
const getUserById = async (id: string) => { }
interface UserCreateRequest { }
const userRepository = new UserRepository()

// ❌ Avoid
const get_user_by_id = () => { }
const user: any = { }
const u = { }
```

### File Organization

```
domains/users/
  ├── handlers/      # Lambda handlers
  ├── services/      # Business logic
  ├── repositories/  # Data access
  ├── models/        # Domain models
  ├── types/         # TypeScript types
  ├── events/        # Domain events
  └── __tests__/     # Tests
```

## Testing

### Unit Tests
- Test business logic in isolation
- Mock external dependencies
- Use `jest` with `ts-jest`

```typescript
describe('UserService', () => {
  it('should create a user', async () => {
    // Arrange
    const request = { email: 'test@example.com' }
    
    // Act
    const user = await userService.createUser(request)
    
    // Assert
    expect(user.email).toBe('test@example.com')
  })
})
```

### Integration Tests
- Test across service boundaries
- Use LocalStack for AWS services
- Test event flows

## Pull Request Process

1. **Title**: Follow conventional commits
   - `feat: add user authentication`
   - `fix: resolve lambda timeout issue`
   - `docs: update setup guide`

2. **Description**:
   - What changes were made
   - Why these changes were necessary
   - How to test the changes

3. **Checklist**:
   - [ ] Code follows style guidelines
   - [ ] Tests added/updated
   - [ ] Documentation updated
   - [ ] No linting errors
   - [ ] All tests pass

## Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Type
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Code style
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build, dependencies

### Scope
- `backend`: Backend application
- `frontend`: Frontend application
- `infra`: Infrastructure
- `types`: Shared types package

### Example
```
feat(backend): implement user creation endpoint

- Add createUser handler
- Add UserService business logic
- Publish user.created event
- Add integration tests

Closes #123
```

## Best Practices

### Code Organization

✅ Keep domains independent
✅ Use dependency injection
✅ Avoid circular dependencies
✅ Keep functions small and focused
✅ Use descriptive names
✅ Add comments for complex logic

### Error Handling

```typescript
// ✅ Good
try {
  await userService.createUser(request)
} catch (error) {
  logger.error('User creation failed', error, { email: request.email })
  throw new BadRequest('Invalid user data')
}

// ❌ Avoid
try {
  await userService.createUser(request)
} catch (e) {
  console.log('error:', e)
  throw e
}
```

### Logging

```typescript
// ✅ Structured logging
logger.info('User created', {
  userId: user.id,
  email: user.email,
  source: 'api'
})

// ❌ Avoid
console.log('User was created: ' + user.id)
```

## Adding New Features

### 1. Create Domain Structure

```bash
mkdir -p apps/backend/src/domains/newfeature/{handlers,services,repositories,types}
```

### 2. Add Types

```typescript
// domains/newfeature/types/feature.types.ts
export interface Feature {
  id: string;
  name: string;
}
```

### 3. Add Service

```typescript
// domains/newfeature/services/featureService.ts
export class FeatureService {
  async createFeature(data: CreateFeatureRequest): Promise<Feature> {
    // Implementation
  }
}
```

### 4. Add Handler

```typescript
// domains/newfeature/handlers/createFeature.handler.ts
export const handler = async (event: APIGatewayProxyEvent) => {
  // Handler implementation
}
```

### 5. Add Tests

```typescript
// Create tests in __tests__ folder
describe('FeatureService', () => { })
```

## Questions?

- Check existing issues on GitHub
- Review documentation in `/docs`
- Create a discussion on GitHub
