#!/bin/bash

# Build iOS SDK (XCFramework) script
# This script builds the iOS XCFramework for distribution

set -e

echo "🔨 Building iOS SDK..."

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "❌ iOS SDK can only be built on macOS"
    exit 1
fi

# Clean previous builds
echo "Cleaning previous builds..."
./gradlew :shared:clean

# Build the shared framework for iOS
echo "Building shared framework for iOS..."
./gradlew :shared:linkDebugFrameworkIosArm64
./gradlew :shared:linkDebugFrameworkIosX64
./gradlew :shared:linkDebugFrameworkIosSimulatorArm64

# Create XCFramework directory
echo "Creating XCFramework..."
XCFRAMEWORK_PATH="build/ios-sdk/SharedSDK.xcframework"
mkdir -p "$(dirname "$XCFRAMEWORK_PATH")"

# Remove existing XCFramework if it exists
if [ -d "$XCFRAMEWORK_PATH" ]; then
    rm -rf "$XCFRAMEWORK_PATH"
fi

# Create XCFramework from individual frameworks
xcodebuild -create-xcframework \
    -framework "shared/build/bin/iosArm64/debugFramework/SharedSDK.framework" \
    -framework "shared/build/bin/iosX64/debugFramework/SharedSDK.framework" \
    -framework "shared/build/bin/iosSimulatorArm64/debugFramework/SharedSDK.framework" \
    -output "$XCFRAMEWORK_PATH"

# Verify the build
if [ -d "$XCFRAMEWORK_PATH" ]; then
    echo "✅ iOS SDK successfully built!"
    echo "📍 Location: $XCFRAMEWORK_PATH"
    
    # Show XCFramework info
    echo "📦 XCFramework info:"
    xcodebuild -list -xcframework "$XCFRAMEWORK_PATH"
else
    echo "❌ iOS SDK build failed!"
    exit 1
fi

echo "🎉 iOS SDK build completed!"