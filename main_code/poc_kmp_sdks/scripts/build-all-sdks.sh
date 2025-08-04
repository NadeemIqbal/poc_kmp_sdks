#!/bin/bash

# Build All SDKs script
# This script builds all platform SDKs in the correct order

set -e

echo "🚀 Building All KMP SDKs..."

# Make sure we're in the right directory
if [ ! -f "build.gradle.kts" ]; then
    echo "❌ Please run this script from the project root directory"
    exit 1
fi

# Make scripts executable
chmod +x scripts/*.sh

# Build shared module first
echo "📦 Building shared module..."
./gradlew :shared:publishToMavenLocal

# Build Android SDK
echo "📱 Building Android SDK..."
./scripts/build-android-sdk.sh

# Build iOS SDK (only on macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 Building iOS SDK..."
    ./scripts/build-ios-sdk.sh
else
    echo "⚠️  Skipping iOS SDK build (macOS required)"
fi

# Build Flutter SDK
echo "🐦 Building Flutter SDK..."
if command -v flutter &> /dev/null; then
    ./scripts/build-flutter-sdk.sh
else
    echo "⚠️  Skipping Flutter SDK build (Flutter not installed)"
fi

# Build React Native SDK
echo "⚛️  Building React Native SDK..."
if command -v node &> /dev/null; then
    ./scripts/build-rn-sdk.sh
else
    echo "⚠️  Skipping React Native SDK build (Node.js not installed)"
fi

echo ""
echo "🎉 All SDK builds completed!"
echo ""
echo "📋 Build Summary:"
echo "  ✅ Shared Module: build/localMaven/"
echo "  ✅ Android SDK: build/localMaven/org/nadeem/project/android-sdk/"

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "  ✅ iOS SDK: build/ios-sdk/SharedSDK.xcframework"
fi

if command -v flutter &> /dev/null; then
    echo "  ✅ Flutter SDK: build/flutter-sdk/"
fi

if command -v node &> /dev/null; then
    echo "  ✅ React Native SDK: build/rn-sdk/"
fi

echo ""
echo "📖 Next Steps:"
echo "  1. Test consumer applications: ./gradlew setupConsumerProjects"
echo "  2. Run Android consumer: cd consumer/android && ../../gradlew assembleDebug"
echo "  3. Run Flutter consumer: cd consumer/flutter && flutter run"
echo "  4. Run RN consumer: cd consumer/rn && npm install && npm run android"