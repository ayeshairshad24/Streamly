plugins {
    // 1. Android Application plugin (First)
    id("com.android.application")
    
    // 2. Kotlin plugin
    id("kotlin-android")
    
    // 3. Flutter plugin (Must be after Android/Kotlin)
    id("dev.flutter.flutter-gradle-plugin")
    
    // 4. Google Services plugin (For Firebase)
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.osiris"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.osiris"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildFeatures {
        buildConfig = true
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

// <<< NEW DEPENDENCIES BLOCK >>>
dependencies {
    // Import the Firebase BoM (Bill of Materials)
    // This manages versions for you to prevent conflicts
    implementation(platform("com.google.firebase:firebase-bom:34.7.0"))

    // You can add Analytics if you want, though Flutter usually handles this via pubspec
    implementation("com.google.firebase:firebase-analytics")
}