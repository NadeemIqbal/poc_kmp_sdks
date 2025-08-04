plugins {
    alias(libs.plugins.androidApplication)
    alias(libs.plugins.kotlinMultiplatform)
    alias(libs.plugins.composeMultiplatform)
    alias(libs.plugins.composeCompiler)
}

kotlin {
    androidTarget()
    
    sourceSets {
        androidMain.dependencies {
            // Local SDK dependency
            implementation(project(":shared"))
            implementation(project(":android"))
            
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
    }
}

android {
    namespace = "org.nadeem.project.consumer.android"
    compileSdk = libs.versions.android.compileSdk.get().toInt()
    
    defaultConfig {
        applicationId = "org.nadeem.project.consumer.android"
        minSdk = libs.versions.android.minSdk.get().toInt()
        targetSdk = libs.versions.android.targetSdk.get().toInt()
        versionCode = 1
        versionName = "1.0"
        
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"
        vectorDrawables {
            useSupportLibrary = true
        }
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
    
    composeOptions {
        kotlinCompilerExtensionVersion = libs.versions.composeMultiplatform.get()
    }
    
    packaging {
        resources {
            excludes += "/META-INF/{AL2.0,LGPL2.1}"
        }
    }
}