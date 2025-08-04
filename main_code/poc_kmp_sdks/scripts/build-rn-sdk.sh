#!/bin/bash

# Build React Native SDK script
# This script prepares the React Native package for distribution

set -e

echo "🔨 Building React Native SDK..."

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed or not in PATH"
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed or not in PATH"
    exit 1
fi

# Navigate to React Native bridge directory
cd rn_bridge

# Clean previous builds
echo "Cleaning previous builds..."
rm -rf node_modules
rm -rf lib
rm -f package-lock.json

# Install dependencies
echo "Installing dependencies..."
npm install

# Run linting
echo "Running ESLint..."
npm run lint

# Run TypeScript check
echo "Running TypeScript check..."
npm run typecheck

# Build the package
echo "Building React Native package..."
npm run prepack

# Run tests if they exist
if [ -d "src/__tests__" ] && [ "$(ls -A src/__tests__)" ]; then
    echo "Running tests..."
    npm test
else
    echo "No tests found, skipping test execution..."
fi

# Validate the package structure
echo "Validating package structure..."
if [ ! -f "package.json" ]; then
    echo "❌ package.json not found!"
    exit 1
fi

if [ ! -f "src/index.ts" ]; then
    echo "❌ Main TypeScript file not found!"
    exit 1
fi

if [ ! -d "lib" ]; then
    echo "❌ Built lib directory not found!"
    exit 1
fi

# Check platform implementations
if [ ! -f "android/src/main/java/org/nadeem/project/rn_bridge/KmpSharedSdkRnModule.kt" ]; then
    echo "❌ Android implementation not found!"
    exit 1
fi

if [ ! -f "ios/KmpSharedSdkRn.swift" ]; then
    echo "❌ iOS implementation not found!"
    exit 1
fi

# Create a dist directory and copy package files
echo "Creating distribution package..."
cd ..
DIST_PATH="build/rn-sdk"
mkdir -p "$DIST_PATH"

# Copy package files
cp -r rn_bridge/* "$DIST_PATH/"

# Remove unnecessary files from distribution
rm -rf "$DIST_PATH/node_modules"
rm -rf "$DIST_PATH/.git"
rm -f "$DIST_PATH/.gitignore"

echo "✅ React Native SDK successfully built!"
echo "📍 Location: $DIST_PATH"
echo "📦 Package structure:"
ls -la "$DIST_PATH"

echo "🎉 React Native SDK build completed!"
echo "💡 To use in a React Native project, add to package.json:"
echo "   \"kmp-shared-sdk-rn\": \"file:path/to/$DIST_PATH\""