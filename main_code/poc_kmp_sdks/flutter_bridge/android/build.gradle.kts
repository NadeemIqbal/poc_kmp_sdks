plugins {
    id("com.android.library")
    id("org.jetbrains.kotlin.android")
}

android {
    namespace = "org.nadeem.project.flutter_bridge"
    compileSdk = 35

    defaultConfig {
        minSdk = 24
        targetSdk = 35
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:2.2.0")
    implementation("androidx.core:core-ktx:1.16.0")
    implementation("io.flutter:flutter_embedding_debug:1.0.0-3316dd8728419ad3534e3f6112aa6291f587078a")
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.8.0")
} 