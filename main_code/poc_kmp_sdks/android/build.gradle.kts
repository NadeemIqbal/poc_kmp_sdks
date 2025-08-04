plugins {
    alias(libs.plugins.androidLibrary)
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.composeMultiplatform)
    alias(libs.plugins.composeCompiler)
    `maven-publish`
}

kotlin {
    androidTarget {
        publishLibraryVariants("release", "debug")
    }
    
    sourceSets {
        androidMain.dependencies {
            implementation(project(":shared"))
            
            // Compose BOM
            implementation(libs.androidx.compose.bom)
            implementation(libs.androidx.compose.ui)
            implementation(libs.androidx.compose.ui.tooling.preview)
            implementation(libs.androidx.compose.material3)
            implementation(libs.androidx.navigation.compose)
            
            // Android specific
            implementation(libs.androidx.core.ktx)
            implementation(libs.androidx.lifecycle.viewmodelCompose)
            implementation(libs.androidx.lifecycle.runtimeCompose)
            implementation(libs.androidx.activity.compose)
            
            // Coroutines
            implementation(libs.kotlinx.coroutines.android)
        }
        
        androidUnitTest.dependencies {
            implementation(libs.junit)
            implementation(libs.kotlin.test)
        }
    }
}

android {
    namespace = "org.nadeem.project.android"
    compileSdk = libs.versions.android.compileSdk.get().toInt()
    
    defaultConfig {
        minSdk = libs.versions.android.minSdk.get().toInt()
        
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        consumerProguardFiles("consumer-rules.pro")
    }
    
    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }
    
    buildFeatures {
        compose = true
    }
}

// Publishing configuration will be added later