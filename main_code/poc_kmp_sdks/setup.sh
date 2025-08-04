#!/bin/bash

# KMP SDK Project Setup Script
# This script sets up the entire project and builds all SDKs

set -e

echo "🚀 Setting up KMP SDK Project..."

# Check prerequisites
echo "🔍 Checking prerequisites..."

# Check Java
if ! command -v java &> /dev/null; then
    echo "❌ Java is not installed. Please install JDK 11 or higher."
    exit 1
fi

# Check if we're in the right directory
if [ ! -f "build.gradle.kts" ]; then
    echo "❌ Please run this script from the project root directory"
    exit 1
fi

# Make all scripts executable
echo "🔧 Making scripts executable..."
chmod +x scripts/*.sh

# Clean everything first
echo "🧹 Cleaning project..."
./gradlew cleanAll || ./gradlew clean

# Build shared module
echo "📦 Building shared module..."
./gradlew :shared:publishToMavenLocal

# Build all SDKs
echo "🏗️  Building all SDKs..."
./scripts/build-all-sdks.sh

# Setup consumer projects
echo "🔨 Setting up consumer projects..."
./gradlew setupConsumerProjects

echo ""
echo "🎉 KMP SDK Project setup completed successfully!"
echo ""
echo "📁 Project Structure:"
echo "  ├── shared/                 # Shared KMP module"
echo "  ├── android/                # Android UI module"
echo "  ├── ios/                    # iOS UI module"
echo "  ├── flutter_bridge/         # Flutter plugin"
echo "  ├── rn_bridge/             # React Native bridge"
echo "  └── consumer/              # Consumer applications"
echo "      ├── android/           # Android consumer"
echo "      ├── flutter/           # Flutter consumer"
echo "      └── rn/               # React Native consumer"
echo ""
echo "📋 What was built:"
echo "  ✅ Shared KMP module with business logic"
echo "  ✅ Android AAR with Jetpack Compose UI"

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "  ✅ iOS XCFramework with SwiftUI"
fi

if command -v flutter &> /dev/null; then
    echo "  ✅ Flutter plugin with method channels"
fi

if command -v node &> /dev/null; then
    echo "  ✅ React Native bridge with TypeScript"
fi

echo "  ✅ Consumer applications for all platforms"
echo ""
echo "🚀 Next Steps:"
echo ""
echo "1. Test Android Consumer:"
echo "   cd consumer/android"
echo "   ../../gradlew assembleDebug"
echo ""

if command -v flutter &> /dev/null; then
    echo "2. Test Flutter Consumer:"
    echo "   cd consumer/flutter"
    echo "   flutter pub get"
    echo "   flutter run"
    echo ""
fi

if command -v node &> /dev/null; then
    echo "3. Test React Native Consumer:"
    echo "   cd consumer/rn"
    echo "   npm install"
    echo "   npm run android  # or npm run ios"
    echo ""
fi

echo "📖 Documentation:"
echo "   • README.md - Project overview and usage"
echo "   • Each module has its own documentation"
echo ""
echo "💡 Tips:"
echo "   • Use './gradlew buildAllSDKs' to rebuild all SDKs"
echo "   • Consumer projects are configured to use local SDKs"
echo "   • Check individual module READMEs for specific instructions"