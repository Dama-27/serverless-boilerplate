# Serverless MERN Frontend

React TypeScript frontend for serverless MERN application with Cognito authentication and API integration.

## Features

- **React 18** - Modern UI library
- **TypeScript** - Type-safe development
- **Vite** - Fast build tool
- **Zustand** - Lightweight state management
- **Axios** - HTTP client with interceptors
- **Cognito** - AWS authentication

## Development

### Install Dependencies
```bash
npm install
```

### Start Development Server
```bash
npm run dev
```

Server runs at `http://localhost:3000`

### Build for Production
```bash
npm run build
```

Output in `dist/` directory

### Preview Production Build
```bash
npm run preview
```

### Run Tests
```bash
npm run test
npm run test:ui
```

## Project Structure

```
src/
  ├── components/     # Reusable React components
  ├── pages/          # Page components
  ├── hooks/          # Custom React hooks
  ├── services/       # API clients
  ├── store/          # Zustand stores
  ├── types/          # TypeScript types
  ├── utils/          # Utility functions
  ├── styles/         # Global styles
  ├── App.tsx         # Root component
  └── main.tsx        # Entry point
```

## Environment Variables

Required in `.env`:
```bash
REACT_APP_API_URL=http://localhost:3001
REACT_APP_COGNITO_DOMAIN=your-domain.auth.us-east-1.amazoncognito.com
REACT_APP_COGNITO_CLIENT_ID=your-client-id
REACT_APP_COGNITO_REGION=us-east-1
```

## API Integration

Make API calls using configured axios client:

```typescript
import { api } from '@/services/api';

const fetchUsers = async () => {
  const { data } = await api.get('/users');
  return data;
};
```

## Cognito Authentication

```typescript
import { useAuth } from '@/hooks/useAuth';

const Component = () => {
  const { user, login, logout } = useAuth();
  
  return (
    <div>
      {user && <p>Welcome {user.email}</p>}
      <button onClick={login}>Sign In</button>
    </div>
  );
};
```

## Building & Deployment

### Build Docker Image
```bash
docker build -f docker/Dockerfile.frontend -t serverless-mern-frontend .
```

### Deploy to S3
```bash
npm run build
aws s3 sync dist/ s3://your-frontend-bucket/
```

## Performance

- Code splitting automatic with Vite
- CSS-in-JS for scoped styling
- Image optimization
- Lazy loading for routes

## Testing

Unit and integration tests using Vitest:

```bash
npm run test           # Run once
npm run test:ui        # Interactive mode
```

## Debugging

Enable debug mode in browser console:
```javascript
localStorage.setItem('debug', 'app:*');
```

## Browser Support

- Modern browsers (Chrome, Firefox, Safari, Edge)
- ES2022+ JavaScript

See [Setup Guide](../../docs/SETUP.md) for more information.
