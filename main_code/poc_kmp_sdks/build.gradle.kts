plugins {
    // this is necessary to avoid the plugins to be loaded multiple times
    // in each subproject's classloader
    alias(libs.plugins.androidApplication) apply false
    alias(libs.plugins.androidLibrary) apply false
    alias(libs.plugins.composeMultiplatform) apply false
    alias(libs.plugins.composeCompiler) apply false
    alias(libs.plugins.kotlinMultiplatform) apply false
    alias(libs.plugins.kotlinSerialization) apply false

}

allprojects {
    repositories {
        google()
        mavenCentral()
        // Local Maven repository for published SDKs
        maven {
            url = uri("${rootProject.buildDir}/localMaven")
        }
    }
}

// Task to clean all modules
tasks.register("cleanAll") {
    group = "build"
    description = "Clean all modules including consumer projects"
    
    dependsOn(
        ":shared:clean",
        ":android:clean",
        ":consumer:android:clean"
    )
}

// Task to build all SDKs
tasks.register("buildAllSDKs") {
    group = "build"
    description = "Build all SDKs (Android AAR, iOS XCFramework, Flutter, React Native)"
    
    dependsOn(
        ":shared:publishToMavenLocal",
        ":android:publishToMavenLocal"
    )
}

// Task to setup consumer projects
tasks.register("setupConsumerProjects") {
    group = "setup"
    description = "Setup all consumer projects with SDK dependencies"
    
    dependsOn("buildAllSDKs")
    
    doLast {
        println("Consumer projects are ready!")
        println("- Android: consumer/android/")
        println("- Flutter: consumer/flutter/")
        println("- React Native: consumer/rn/")
    }
}