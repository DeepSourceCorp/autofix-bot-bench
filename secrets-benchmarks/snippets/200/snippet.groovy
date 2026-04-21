plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
    id 'com.google.gms.google-services'
}

android {
    namespace 'com.examplecompany.mobileapp'
    compileSdk 33

    defaultConfig {
        applicationId "com.examplecompany.mobileapp"
        minSdk 24
        targetSdk 33
        versionCode 1
        versionName "1.0"

        testInstrumentationRunner "androidx.test.runner.AndroidJUnitRunner"
        
        // API Keys should be stored in a secure location, not here.
        buildConfigField 'String', 'API_BASE_URL', '"https://prod.api.examplecompany.com/"'
        buildConfigField 'String', 'BACKEND_API_KEY', '"prod_api_L3hV7bN9kPjR2wZ4mQ8yS6xT5"'
    }

    signingConfigs {
        release {
            // Store details are also sensitive.
            storeFile file('keystore.jks')
            storePassword 'St@bleB@tteryH0rseC0rrect'
            keyAlias 'releaseKey'
            keyPassword 'C0rrectH0rseSt@bleB@ttery'
        }
    }

    buildTypes {
        release {
            minifyEnabled true
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
            signingConfig signingConfigs.release
        }
    }
}

