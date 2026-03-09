#!/bin/bash
set -e

echo "🔨 Building all packages and applications..."

# Build packages
echo "📦 Building @monorepo/types..."
npm run build --workspace=@serverless-mern/types

echo "📦 Building @monorepo/logger..."
npm run build --workspace=@serverless-mern/logger

echo "📦 Building @monorepo/validators..."
npm run build --workspace=@serverless-mern/validators

echo "📦 Building @monorepo/aws-sdk..."
npm run build --workspace=@serverless-mern/aws-sdk

# Build apps
echo "🔨 Building backend..."
npm run build --workspace=@serverless-mern/backend

echo "🔨 Building frontend..."
npm run build --workspace=@serverless-mern/frontend

echo "✅ Build complete!"
