#!/bin/bash

# Build Flutter SDK script
# This script prepares the Flutter plugin for distribution

set -e

echo "🔨 Building Flutter SDK..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    exit 1
fi

# Navigate to Flutter bridge directory
cd flutter_bridge

# Clean previous builds
echo "Cleaning previous builds..."
flutter clean

# Get dependencies
echo "Getting Flutter dependencies..."
flutter pub get

# Analyze the code
echo "Analyzing Flutter code..."
flutter analyze

# Run tests if they exist
if [ -d "test" ] && [ "$(ls -A test)" ]; then
    echo "Running Flutter tests..."
    flutter test
else
    echo "No tests found, skipping test execution..."
fi

# Validate the plugin structure
echo "Validating plugin structure..."
if [ ! -f "pubspec.yaml" ]; then
    echo "❌ pubspec.yaml not found!"
    exit 1
fi

if [ ! -f "lib/kmp_shared_sdk_flutter.dart" ]; then
    echo "❌ Main library file not found!"
    exit 1
fi

# Check platform implementations
if [ ! -f "android/src/main/kotlin/org/nadeem/project/flutter_bridge/KmpSharedSdkFlutterPlugin.kt" ]; then
    echo "❌ Android implementation not found!"
    exit 1
fi

if [ ! -f "ios/Classes/KmpSharedSdkFlutterPlugin.swift" ]; then
    echo "❌ iOS implementation not found!"
    exit 1
fi

# Create a dist directory and copy plugin files
echo "Creating distribution package..."
cd ..
DIST_PATH="build/flutter-sdk"
mkdir -p "$DIST_PATH"

# Copy plugin files
cp -r flutter_bridge/* "$DIST_PATH/"

# Remove unnecessary files from distribution
rm -rf "$DIST_PATH/.dart_tool"
rm -rf "$DIST_PATH/build"

echo "✅ Flutter SDK successfully built!"
echo "📍 Location: $DIST_PATH"
echo "📦 Plugin structure:"
ls -la "$DIST_PATH"

echo "🎉 Flutter SDK build completed!"
echo "💡 To use in a Flutter project, add to pubspec.yaml:"
echo "   kmp_shared_sdk_flutter:"
echo "     path: path/to/$DIST_PATH"