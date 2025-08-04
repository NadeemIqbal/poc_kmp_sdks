rootProject.name = "poc_kmp_sdks"
enableFeaturePreview("TYPESAFE_PROJECT_ACCESSORS")

pluginManagement {
    repositories {
        google {
            mavenContent {
                includeGroupAndSubgroups("androidx")
                includeGroupAndSubgroups("com.android")
                includeGroupAndSubgroups("com.google")
            }
        }
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositories {
        google {
            mavenContent {
                includeGroupAndSubgroups("androidx")
                includeGroupAndSubgroups("com.android")
                includeGroupAndSubgroups("com.google")
            }
        }
        mavenCentral()
        // Local Maven repository for published SDKs
        maven {
            url = uri("build/localMaven")
        }
    }
}

// Main SDK modules
include(":shared")
include(":android")
include(":composeApp")

// Consumer projects
include(":consumer-android")

// Configure project paths
project(":shared").projectDir = file("main_code/poc_kmp_sdks/shared")
project(":android").projectDir = file("main_code/poc_kmp_sdks/android")
project(":composeApp").projectDir = file("main_code/poc_kmp_sdks/composeApp")
project(":consumer-android").projectDir = file("consumer/android")