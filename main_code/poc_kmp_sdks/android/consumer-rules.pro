# Consumer ProGuard rules for Android SDK

# Keep all public classes and methods in the SDK
-keep public class ui.** { *; }
-keep public class main_code.** { *; }

# Keep Compose related classes
-keep class androidx.compose.** { *; }

# Keep Kotlin serialization classes
-keep class kotlinx.serialization.** { *; }
-keepattributes *Annotation*, InnerClasses
-dontnote kotlinx.serialization.**

# Keep coroutines
-keep class kotlinx.coroutines.** { *; }

# Prevent obfuscation of data classes
-keep class main_code.data.** { *; }