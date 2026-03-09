#!/bin/bash
set -e

echo "🚀 Starting local development environment..."
echo "   - LocalStack (AWS simulation)"
echo "   - Backend (Lambda local)"
echo "   - Frontend (React dev server)"
echo ""

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
  echo "❌ Docker is not running. Please start Docker Desktop."
  exit 1
fi

# Start docker compose
echo "📦 Starting Docker containers..."
docker-compose -f docker/docker-compose.local.yml up -d

echo ""
echo "✅ Local environment started!"
echo ""
echo "Services:"
echo "  Frontend:   http://localhost:3000"
echo "  Backend:    http://localhost:3001"
echo "  LocalStack: http://localhost:4566"
echo ""
echo "To stop: docker-compose -f docker/docker-compose.local.yml down"
