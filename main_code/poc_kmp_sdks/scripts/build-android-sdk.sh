#!/bin/bash

# Build Android SDK (AAR) script
# This script builds and publishes the Android SDK to local Maven repository

set -e

echo "🔨 Building Android SDK..."

# Clean previous builds
echo "Cleaning previous builds..."
./gradlew :android:clean

# Build and publish Android SDK
echo "Building and publishing Android AAR..."
./gradlew :android:publishToMavenLocal

# Verify the build
if [ -d "build/localMaven/org/nadeem/project/android-sdk" ]; then
    echo "✅ Android SDK successfully built and published!"
    echo "📍 Location: build/localMaven/org/nadeem/project/android-sdk/"
    
    # List available versions
    echo "📦 Available versions:"
    ls -la build/localMaven/org/nadeem/project/android-sdk/
else
    echo "❌ Android SDK build failed!"
    exit 1
fi

echo "🎉 Android SDK build completed!"