#!/bin/bash
set -e

echo "🧪 Running tests..."
npm test -- --coverage

echo "✅ Tests complete!"
