import org.gradle.api.JavaVersion
import java.util.Properties

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

fun localProperties(): Properties {
    val properties = Properties()
    val localPropertiesFile = project.rootProject.file("local.properties")
    if (localPropertiesFile.exists()) {
        properties.load(localPropertiesFile.inputStream())
    }
    return properties
}

val flutterVersionCode = localProperties().getProperty("flutter.versionCode")?.toInt() ?: 1
val flutterVersionName = localProperties().getProperty("flutter.versionName") ?: "1.0"

android {
    namespace = "com.example.tracky_flutter"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "27.0.12077973"

    compileOptions {
        // Java 8 문법 지원 및 디슈가링 활성화
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = "1.8"
    }

    sourceSets {
        getByName("main") {
            java.srcDirs("src/main/kotlin")
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.tracky_flutter"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // 카카오 네이티브 앱 키 설정
        val kakaoAppKey = project.findProperty("KAKAO_NATIVE_APP_KEY") as String? ?: "1414e098bb3e8e534da7a603c95c573e"
manifestPlaceholders["KAKAO_NATIVE_APP_KEY"] = kakaoAppKey

    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Java 1.8 버전에 맞는 코틀린 표준 라이브러리 사용
    implementation(kotlin("stdlib-jdk8"))
    // 디슈가링 라이브러리 추가
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
}
