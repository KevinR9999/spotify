pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

dependencyResolutionManagement {
    repositories {
        google()
        mavenCentral()
        maven { url = uri("https://maven.google.com/") }
    }
}

rootProject.name = "spotify_clone"

include(":app")
include(":spotify-app-remote")
