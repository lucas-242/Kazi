plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties
import java.io.FileInputStream

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")

if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}


android {
    namespace = "com.myservices.kazi"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    flavorDimensions += "environment"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.myservices.kazi"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        getByName("debug") {
            keyAlias = keystoreProperties.getProperty("keyAlias.debug")
            keyPassword = keystoreProperties.getProperty("keyPassword.debug")
            storePassword = keystoreProperties.getProperty("storePassword.debug")

            val storeFilePath = keystoreProperties.getProperty("storeFile.debug")
            storeFile = storeFilePath?.let { file(it) }
        }

        create("release") {
            keyAlias = keystoreProperties.getProperty("keyAlias.release")
            keyPassword = keystoreProperties.getProperty("keyPassword.release")
            storePassword = keystoreProperties.getProperty("storePassword.release")

            val storeFilePath = keystoreProperties.getProperty("storeFile.release")
            storeFile = storeFilePath?.let { file(it) }
        }
    }

    buildTypes {
        debug {
            resValue(
                "string",
                "ADMOB_APPID",
                keystoreProperties.getProperty("adMobAppId.debug")
            )
            signingConfig = signingConfigs.getByName("debug")
        }
        // Created by the Flutter plugin as a copy of `debug`, taken before the
        // block above runs, so it inherits none of debug's resValues.
        getByName("profile") {
            resValue(
                "string",
                "ADMOB_APPID",
                keystoreProperties.getProperty("adMobAppId.debug")
            )
            signingConfig = signingConfigs.getByName("debug")
        }
        release {
            resValue(
                "string",
                "ADMOB_APPID",
                keystoreProperties.getProperty("adMobAppId.release")
            )
            signingConfig = signingConfigs.getByName("release")
        }
    }

    productFlavors {
        create("staging") {
            dimension = "environment"
            applicationIdSuffix = ".staging"

            resValue(
                type = "string",
                name = "app_name",
                value = "Kazi Staging"
            )
        }

        create("prod") {
            dimension = "environment"

            resValue(
                type = "string",
                name = "app_name",
                value = "Kazi"
            )
        }
    }
}

flutter {
    source = "../.."
}
