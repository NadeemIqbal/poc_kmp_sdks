import org.jetbrains.kotlin.gradle.ExperimentalKotlinGradlePluginApi
import org.jetbrains.kotlin.gradle.dsl.JvmTarget

plugins {
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.androidLibrary)
    alias(libs.plugins.kotlinSerialization)
    `maven-publish`
}

kotlin {
    androidTarget {
        @OptIn(ExperimentalKotlinGradlePluginApi::class)
        compilerOptions {
            jvmTarget.set(JvmTarget.JVM_11)
        }
        publishLibraryVariants("release", "debug")
    }
    
    listOf(
        iosX64(),
        iosArm64(),
        iosSimulatorArm64()
    ).forEach { iosTarget ->
        iosTarget.binaries.framework {
            baseName = "SharedSDK"
            isStatic = true
        }
    }
    
    // JavaScript target for React Native
    js(IR) {
        browser()
        nodejs()
        binaries.library()
    }
    
    sourceSets {
        commonMain.dependencies {
            implementation(libs.kotlinx.coroutines.core)
            implementation(libs.kotlinx.serialization.json)
            implementation(libs.kotlinx.datetime)
        }
        
        commonTest.dependencies {
            implementation(libs.kotlin.test)
        }
        
        androidMain.dependencies {
            implementation(libs.kotlinx.coroutines.android)
        }
        
        iosMain.dependencies {
            // iOS specific dependencies
        }
        
        jsMain.dependencies {
            // JavaScript specific dependencies for React Native
        }
    }
}

android {
    namespace = "org.nadeem.project.shared"
    compileSdk = libs.versions.android.compileSdk.get().toInt()
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    defaultConfig {
        minSdk = libs.versions.android.minSdk.get().toInt()
    }
}

// Publishing configuration for local Maven repository
publishing {
    publications {
        create<MavenPublication>("maven") {
            groupId = "org.nadeem.project"
            artifactId = "shared-sdk"
            version = "1.0.0"
            
            pom {
                name.set("Shared SDK")
                description.set("Kotlin Multiplatform shared SDK")
                url.set("https://github.com/your-org/shared-sdk")
                
                licenses {
                    license {
                        name.set("The Apache License, Version 2.0")
                        url.set("http://www.apache.org/licenses/LICENSE-2.0.txt")
                    }
                }
                
                developers {
                    developer {
                        id.set("nadeem")
                        name.set("Nadeem")
                        email.set("nadeem@yourorg.com")
                    }
                }
            }
        }
    }
    
    repositories {
        maven {
            url = uri("${rootProject.buildDir}/localMaven")
        }
    }
}
