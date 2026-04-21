android {
    compileSdkVersion 33
    defaultConfig {
        applicationId "com.example.securemessenger"
        minSdkVersion 24
        targetSdkVersion 33
        versionCode 102
        versionName "1.2.0"
    }

    signingConfigs {
        release {
            storeFile file(System.getenv("KEYSTORE_FILE"))
            storePassword System.getenv("KEYSTORE_PASSWORD")
            keyAlias System.getenv("KEY_ALIAS")
            keyPassword System.getenv("KEY_PASSWORD")
        }
    }

    buildTypes {
        release {
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
            signingConfig signingConfigs.release
        }
        debug {
            applicationIdSuffix ".debug"
        }
    }

    flavorDimensions "version"
    productFlavors {
        production {
            dimension "version"
            // This key is used for server-to-device push notifications via FCM
            buildConfigField "String", "FCM_SERVER_KEY", '"AAAApcJ-Hk4:APA91bE3rZtUq_yG9sVxW5pKjL7hB8dC1fN0mO4iG2pJ6oS4tA0cQ7nV1wR9zY_lF5aK8uI3eB7fJ9dC2gH6vM5"'
        }
        staging {
            dimension "version"
            applicationIdSuffix ".staging"
            buildConfigField "String", "FCM_SERVER_KEY", '"AAAAizX-Tq0:APA91bF...staging-key..."' // Placeholder
        }
    }
}
