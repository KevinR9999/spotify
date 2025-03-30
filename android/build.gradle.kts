plugins {
    id("com.android.application") version "8.0.2" apply false
    id("kotlin-android")
}

android {
    namespace = "com.example.spotify_clone" // ✅ Define el namespace
    compileSdk = 34 // 🔹 Asegúrate de que coincide con tu proyecto

    defaultConfig {
        applicationId = "com.example.spotify_clone"
        minSdk = 21
        targetSdk = 34
        versionCode = 1
        versionName = "1.0"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    ndkVersion = "27.0.12077973" // ✅ Asegura que la versión del NDK sea correcta

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
}

dependencies {
    implementation("androidx.core:core-ktx:1.9.0")
    implementation("androidx.appcompat:appcompat:1.6.1")
    implementation("com.google.android.material:material:1.8.0")

    // Spotify SDK
    implementation("com.spotify.android:auth:2.1.1")
    implementation("com.spotify.android:spotify-app-remote:0.8.0") // 🔹 Usa la versión más reciente

    // Kotlin Coroutines
    implementation("org.jetbrains.kotlinx:kotlinx-coroutines-android:1.6.4")
}
