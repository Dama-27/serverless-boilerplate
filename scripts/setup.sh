#!/bin/bash
set -e

echo "🚀 Setting up Serverless MERN monorepo..."

# Install dependencies
echo "📦 Installing dependencies..."
npm install

# Build all packages and apps
echo "🔨 Building backend..."
npm run build --workspace=@serverless-mern/backend

echo "🔨 Building frontend..."
npm run build --workspace=@serverless-mern/frontend

# Setup environment
if [ ! -f .env.dev ]; then
  echo "📝 Creating .env.dev..."
  cp .env.example .env.dev
fi

echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "  npm run local-dev          # Start LocalStack + app"
echo "  npm run test              # Run tests"
echo "  npm run lint              # Run linting"
