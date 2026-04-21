# build.gradle (Module: app)
plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
    id 'io.fabric'
}

android {
    compileSdkVersion 33

    defaultConfig {
        applicationId "com.example.securewallet"
        minSdkVersion 24
        targetSdkVersion 33
        versionCode 1
        versionName "1.0"

        // API keys should not be stored here
        buildConfigField "String", "COINMARKETCAP_API_KEY", '"9a8b7c6d-5e4f-3a2b-1c0d-9f8e7d6c5b4a"'
        buildConfigField "String", "ETHERSCAN_API_KEY", '"8S5R3ZQXDI1VMEG9N4Y2QWB7A7JH8W5C6I"'
    }

    signingConfigs {
        release {
            storeFile file('keystore/release.jks')
            storePassword 'sUp3rS3cur3P@ssw0rd'
            keyAlias 'releaseKey'
            keyPassword 'k3yP@ssw0rdF0rR3l3ase'
        }
    }

    buildTypes {
        release {
            minifyEnabled true
            signingConfig signingConfigs.release
        }
    }
}
