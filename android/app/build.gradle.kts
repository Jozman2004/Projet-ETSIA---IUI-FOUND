plugins {
    id("com.android.application")
    id("kotlin-android")
    // Le plugin Flutter doit être appliqué en dernier
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.untitled2"
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
        applicationId "com.example.untitled2"
        minSdkVersion 21
        targetSdkVersion 33
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
                // Add this line if missing:
                manifestPlaceholders = [applicationName: "io.flutter.app.FlutterApplication"]
    }
    buildTypes {
        release {
            // Debug key utilisée pour simplifier le test en release
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    classpath 'com.android.tools.build:gradle:7.4.2'
    implementation("androidx.core:core:1.12.0")
}
