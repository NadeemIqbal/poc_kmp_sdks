# KMP Cross-Platform SDKs Proof of Concept

## Overview

This project demonstrates a proof of concept for Kotlin Multiplatform (KMP) SDKs that can be consumed by multiple platforms including Android, iOS, Flutter, and React Native. The goal is to share business logic and data models across all platforms while maintaining platform-specific UI implementations.

## Project Structure

```
poc_kmp_sdks/
├── shared/                    # Core shared business logic
│   ├── src/commonMain/       # Common Kotlin code
│   ├── src/androidMain/      # Android-specific implementations
│   └── src/iosMain/          # iOS-specific implementations
├── android/                   # Android SDK module
├── flutter_bridge/           # Flutter plugin bridge
├── rn_bridge/                # React Native bridge
├── consumer/                 # Consumer applications
│   ├── android/              # Android consumer app
│   ├── flutter/              # Flutter consumer app
│   └── rn/                   # React Native consumer app
└── scripts/                  # Build scripts
```

## Architecture

### Shared SDK Core

The `SharedSDK` class serves as the main entry point for all platform implementations:

- **Data Models**: `User` and `Product` entities
- **Use Cases**: Business logic for data operations
- **Repositories**: Data access layer with fake implementations
- **Platform Services**: Platform-specific functionality injection

### Key Features

- **Cross-platform data operations**: Get users, products, search functionality
- **Platform navigation**: Navigate between screens across platforms
- **Platform services**: Logging, messaging, device info
- **Shared business logic**: Use cases and repositories

## Supported Platforms

### Android
- Native Android SDK (AAR)
- Compose Multiplatform UI
- Platform-specific navigation

### iOS
- XCFramework for iOS integration
- SwiftUI implementations
- Native iOS navigation

### Flutter
- Flutter plugin bridge
- Dart bindings for shared functionality
- Platform channel communication

### React Native
- Native module bridge
- TypeScript definitions
- JavaScript/TypeScript API

## Getting Started

### Prerequisites

- Kotlin 1.9+
- Android Studio / IntelliJ IDEA
- Gradle 8.0+
- For iOS: Xcode 14+ (macOS only)
- For Flutter: Flutter SDK
- For React Native: Node.js

### Building All SDKs

```bash
# Make scripts executable
chmod +x scripts/*.sh

# Build all SDKs
./scripts/build-all-sdks.sh
```

### Individual SDK Builds

```bash
# Android SDK only
./scripts/build-android-sdk.sh

# iOS SDK only (macOS required)
./scripts/build-ios-sdk.sh

# Flutter SDK only
./scripts/build-flutter-sdk.sh

# React Native SDK only
./scripts/build-rn-sdk.sh
```

### Gradle Tasks

```bash
# Clean all modules
./gradlew cleanAll

# Build all SDKs
./gradlew buildAllSDKs

# Setup consumer projects
./gradlew setupConsumerProjects
```

## Consumer Applications

### Android Consumer

```bash
cd consumer/android
../../gradlew assembleDebug
```

### Flutter Consumer

```bash
cd consumer/flutter
flutter pub get
flutter run
```

### React Native Consumer

```bash
cd consumer/rn
npm install
npm run android  # or npm run ios
```

## SDK Integration

### Android Integration

```kotlin
// Initialize SDK
val sharedSDK = SharedSDK(
    platformServices = AndroidPlatformServices(),
    platformNavigator = AndroidNavigator()
)
sharedSDK.initialize()

// Use SDK
val users = sharedSDK.getUsers()
sharedSDK.navigateToUserDetails("user123")
```

### iOS Integration

```swift
// Initialize SDK
let sharedSDK = SharedSDK(
    platformServices: IOSPlatformServices(),
    platformNavigator: IOSNavigator()
)
sharedSDK.initialize()

// Use SDK
let users = await sharedSDK.getUsers()
sharedSDK.navigateToUserDetails(userId: "user123")
```

### Flutter Integration

```dart
// Initialize SDK
final sharedSDK = KmpSharedSdkFlutter();
await sharedSDK.initialize();

// Use SDK
final users = await sharedSDK.getUsers();
await sharedSDK.navigateToUserDetails("user123");
```

### React Native Integration

```typescript
// Initialize SDK
import { KmpSharedSdk } from 'kmp-shared-sdk-rn';

const sharedSDK = new KmpSharedSdk();
await sharedSDK.initialize();

// Use SDK
const users = await sharedSDK.getUsers();
await sharedSDK.navigateToUserDetails("user123");
```

## Current State

### Implemented Features

- Shared data models (User, Product)
- Business logic use cases
- Repository pattern with fake data
- Platform-specific navigation
- Platform services abstraction
- Cross-platform SDK builds

### Platform-Specific UIs

Currently, each platform has separate UI implementations:

- **Android**: Compose Multiplatform screens
- **iOS**: SwiftUI views
- **Flutter**: Dart widgets
- **React Native**: React components

### Future Roadmap

The project is designed to transition to shared UI components:

1. **Phase 1**: Shared business logic (Current)
2. **Phase 2**: Shared UI components using Compose Multiplatform
3. **Phase 3**: Unified navigation and state management
4. **Phase 4**: Platform-specific UI customization

## Development

### Adding New Features

1. Add data models in `shared/src/commonMain/kotlin/main_code/data/`
2. Create use cases in `shared/src/commonMain/kotlin/main_code/domain/`
3. Implement repositories in `shared/src/commonMain/kotlin/main_code/repository/`
4. Add methods to `SharedSDK` class
5. Update platform-specific bridges if needed

### Platform-Specific Implementation

- **Android**: Implement in `shared/src/androidMain/`
- **iOS**: Implement in `shared/src/iosMain/`
- **Flutter**: Update `flutter_bridge/` plugin
- **React Native**: Update `rn_bridge/` module

## Build Outputs

After building, SDKs are available in:

- **Android**: `build/localMaven/org/nadeem/project/android-sdk/`
- **iOS**: `build/ios-sdk/SharedSDK.xcframework`
- **Flutter**: `build/flutter-sdk/`
- **React Native**: `build/rn-sdk/`

## Testing

### Unit Tests

```bash
./gradlew shared:test
```

### Consumer App Testing

Each consumer application includes basic integration tests to verify SDK functionality.

## Contributing

1. Follow the existing project structure
2. Add tests for new features
3. Update build scripts if adding new platforms
4. Test on all target platforms

## License

This project is a proof of concept and may be subject to specific licensing terms.