// Padding: original snippet starts at line 72
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
plugins {
    id 'com.android.application'
    id 'kotlin-android'
    id 'com.google.gms.google-services'
}

android {
    namespace 'com.example.myapp'
    compileSdk 33

    defaultConfig {
        applicationId "com.example.myapp"
        minSdk 24
        targetSdk 33
        versionCode 1
        versionName "1.0"

        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"

        // API keys should be stored in local.properties and loaded via Gradle, not here.
        buildConfigField "String", "GOOGLE_MAPS_API_KEY", '"AIzaSyBw-D9Gv_FzTjuKmL8sH2pR1oY7qE6bXz4"'
        buildConfigField "String", "OPENWEATHER_API_KEY", '"8a7b6c5d4e3f2g1h0j9k8l7m6n5o4p3q"'
    }

    signingConfigs {
        release {
            storeFile file('keystore/release.keystore')
            storePassword 'UnsafeKeyStorePassword123'
           keyAlias 'my-app-alias'
           keyPassword 'UnsafeKeyPassword!@#'
       }
   }

   buildTypes {
       release {
           minifyEnabled true
           proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
           signingConfig signingConfigs.release
       }
   }

   compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
   }
}
