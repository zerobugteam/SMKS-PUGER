# Panduan & Dokumentasi Troubleshooting GitHub Actions Workflow (CI/CD)

Dokumentasi ini mencatat fungsi, riwayat masalah, analisis akar penyebab (root cause), dan seluruh solusi teknis yang diterapkan untuk memperbaiki workflow build otomatis Flutter APK pada repositori **SMKS-PUGER**.

---

## 1. Fungsi Workflow GitHub Actions

File workflow berada di: [`.github/workflows/build_apk.yml`](../.github/workflows/build_apk.yml)

### Tujuan & Manfaat
Workflow ini menerapkan pipeline **Continuous Integration & Continuous Deployment (CI/CD)**:
* **Build Otomatis**: Setiap kali ada pembaruan kode yang di-*push* ke branch `main` atau `master` (atau dipicu manual melalui menu *Run workflow* di tab Actions), server Ubuntu GitHub Actions akan otomatis:
  1. Menyiapkan environment Java 17 (`Zulu JDK`) dengan Gradle cache.
  2. Menyiapkan Flutter SDK versi stable dengan caching dependencies.
  3. Mengunduh dependency project (`flutter pub get`).
  4. Mengompilasi aplikasi menjadi APK release siap pasang (`flutter build apk --release`).
  5. Mengunggah file installer (`app-release.apk`) ke tab **Artifacts** di GitHub Actions.
* **Manfaat Tim**: Pengembang dan pengguna dapat mengunduh installer APK terbaru langsung dari GitHub tanpa perlu mengompilasi manual di komputer masing-masing.

---

## 2. Riwayat Permasalahan & Analisis Akar Masalah (Root Cause)

Selama pengujian pipeline build otomatis, ditemukan beberapa kendala beruntun yang menyebabkan workflow gagal terus (*All checks have failed*):

### Masalah 1: Duplikasi Blok Konfigurasi di `android/app/build.gradle`
* **Gejala**: Build langsung berhenti gagal dalam waktu ~1 menit pada proses evaluasi Gradle.
* **Penyebab**: File `android/app/build.gradle` sempat tertempel (copy-paste) dua kali secara utuh (baris 1–44 dan baris 45–89 sama persis). Gradle melarang lebih dari satu blok `plugins { ... }` atau redeklarasi blok `android { ... }` dalam satu file script.
* **Solusi**: Menghapus blok duplikat dan menyisakan satu blok konfigurasi yang valid.

---

### Masalah 2: Kegagalan Step `flutter doctor --android-licenses`
* **Gejala**: Pipeline gagal saat mengeksekusi perintah:
  ```bash
  yes | flutter doctor --android-licenses
  ```
* **Penyebab**: Perintah ini membutuhkan Android SDK `cmdline-tools` terpasang di lokasi spesifik yang dideteksi oleh Flutter. Pada runner GitHub Actions `ubuntu-latest`, direktori ini terkadang tidak terpetakan secara default sehingga memicu error exit non-zero. Runner GitHub Actions sebenarnya sudah menyertakan Android SDK resmi dengan lisensi yang sudah disetujui secara otomatis.
* **Solusi**: Menghapus step manual `flutter doctor --android-licenses` dari file workflow YAML.

---

### Masalah 3: Konflik File Ganda (Groovy `.gradle` vs Kotlin DSL `.gradle.kts`)
* **Gejala**: Di dalam folder `android/` terdapat dua versi file konfigurasi yang berdampingan:
  * `settings.gradle` dan `settings.gradle.kts`
  * `build.gradle` dan `build.gradle.kts`
  * `android/app/build.gradle` dan `android/app/build.gradle.kts`
* **Penyebab**: Saat kedua format ada, Gradle secara otomatis memprioritaskan file Kotlin DSL (`.gradle.kts`). Sementara itu, di dalam file `.gradle.kts` tersebut terdapat versi plugin fiktif yang tidak valid di repository Maven:
  ```kotlin
  id("com.android.application") version "9.3.1" apply false
  id("org.jetbrains.kotlin.android") version "2.4.20" apply false
  ```
* **Solusi**: Menghapus seluruh file `.gradle.kts` yang redundant (`settings.gradle.kts`, `build.gradle.kts`, dan `app/build.gradle.kts`) agar Gradle hanya membaca satu standar Groovy DSL (`.gradle`) yang bersih.

---

### Masalah 4: `Language version 1.4 is no longer supported; please, use version 1.8 or greater`
* **Gejala**: Kompilasi task internal Gradle Flutter gagal dengan pesan:
  ```text
  e: Language version 1.4 is no longer supported; please, use version 1.8 or greater.
  FAILURE: Build failed with an exception.
  * What went wrong:
  Execution failed for task ':gradle:compileKotlin'.
  ```
* **Penyebab**: 
  1. Versi Kotlin bawaan di `android/settings.gradle` sebelumnya diset ke `1.7.10`. Versi ini secara default masih mengizinkan/menggunakan aturan bahasa Kotlin `1.4`.
  2. GitHub Actions menggunakan runner modern dengan Flutter 3.27+ dan Java 17 yang membawa Kotlin compiler 2.0+. Compiler Kotlin baru sudah secara resmi menghapus (*drop*) dukungan untuk Kotlin Language Version 1.4 ke bawah.
  3. Versi Gradle Wrapper (`7.6.3`) dan Android Gradle Plugin (`7.3.0`) terlalu usang untuk standar Flutter modern.
* **Solusi**:
  1. Upgrade **Gradle Wrapper** dari `7.6.3` ke **`8.4`** di `gradle-wrapper.properties`.
  2. Upgrade **Android Gradle Plugin (AGP)** dari `7.3.0` ke **`8.3.2`** di `android/settings.gradle`.
  3. Upgrade **Kotlin Plugin** dari `1.7.10` ke **`1.9.24`** di `android/settings.gradle`.
  4. Menetapkan target kompilasi Java dan JVM ke **Java 17** di `android/app/build.gradle`.

---

### Masalah 5: Duplikasi Package & Nama Namespace Android
* **Gejala**: Terdapat dua folder sumber package di `android/app/src/main/kotlin/com/example/`:
  * `flutter_application_1` (bawaan template awal)
  * `smk_puger_digital` (aplikasi aktual)
* **Solusi**: Menghapus folder `flutter_application_1` dan menyelaraskan konfigurasi `namespace` serta `applicationId` pada `android/app/build.gradle` ke `com.example.smk_puger_digital`.

---

### Masalah 6: Inkompatibilitas AGP 8.3.2 dengan Kotlin Gradle Plugin (`lower than the minimum supported 8.5.2`)
* **Gejala**: Build melempar error:
  ```text
  > Android Gradle Plugin Version Incompatible with Kotlin Gradle Plugin
  Kotlin Gradle Plugin <-> Android Gradle Plugin compatibility issue:
  The applied Android Gradle Plugin version (8.3.2) is lower than the minimum supported 8.5.2.
  Solution: Please update the Android Gradle Plugin version to at least 8.5.2.
  ```
* **Penyebab**: Kotlin Gradle Plugin yang digunakan oleh Flutter SDK stable mewajibkan Android Gradle Plugin (AGP) minimal versi `8.5.2`. Sedangkan AGP 8.5.2 mewajibkan Gradle Wrapper minimal versi `8.7`.
* **Solusi**:
  1. Upgrade AGP dari `8.3.2` ke **`8.5.2`** di `android/settings.gradle`.
  2. Upgrade Gradle Wrapper dari `8.4` ke **`8.7`** (`gradle-8.7-all.zip`) di `android/gradle/wrapper/gradle-wrapper.properties`.

---

### Masalah 7: Flutter Dependency Validation Check (`Gradle version 8.7.0 is lower than Flutter's minimum supported version of 9.3.1`)
* **Gejala**: Kompilasi terhenti oleh plugin Flutter (`dev.flutter.flutter-gradle-plugin`):
  ```text
  > Error: Your project's Gradle version (8.7.0) is lower than Flutter's minimum supported version of 9.3.1. Please upgrade your Gradle version. 
    Alternatively, use the flag "--android-skip-build-dependency-validation" to bypass this check.
  ```
* **Penyebab**: Flutter SDK stable modern menyertakan pemeriksaan ketat terhadap kompatibilitas versi Gradle/AGP default.
* **Solusi**: Menambahkan flag resmi `--android-skip-build-dependency-validation` pada langkah build APK di workflow:
  ```yaml
  - name: Build APK Release
    run: flutter build apk --release --android-skip-build-dependency-validation
  ```

---

### Masalah 8: Evaluasi Prematur Gradle (`ApplicationExtension.getDefaultConfig()`)
* **Gejala**: Build gagal saat membaca `android/build.gradle` baris 13:
  ```text
  * Where:
  Build file 'android/build.gradle' line: 13
  * What went wrong:
  A problem occurred evaluating root project 'android'.
  > 'com.android.build.api.dsl.ApplicationDefaultConfig com.android.build.api.dsl.ApplicationExtension.getDefaultConfig()'
  ```
* **Penyebab**: Blok lama `subprojects { project.evaluationDependsOn(":app") }` di root `android/build.gradle` memaksa Gradle mengevaluasi modul `:app` lebih awal secara tidak sinkron sebelum subproject selesai dikonfigurasi. Pada AGP modern (8.x+), pemanggilan prematur ini memicu error internal `ApplicationExtension.getDefaultConfig()`.
* **Solusi**: Menghapus blok `subprojects { project.evaluationDependsOn(":app") }` dari `android/build.gradle`. Gradle modern sudah otomatis mengelola dependensi antar modul secara deklaratif.

---

## 3. Ringkasan File Konfigurasi Akhir

### A. `.github/workflows/build_apk.yml`
```yaml
name: Build Flutter APK

on:
  push:
    branches: [ main, master ]
  workflow_dispatch:

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Java
        uses: actions/setup-java@v4
        with:
          distribution: 'zulu'
          java-version: '17'
          cache: 'gradle'

      - name: Set up Flutter
        uses: subosito/flutter-action@v2
        with:
          channel: 'stable'
          cache: true

      - name: Install dependencies
        run: flutter pub get

      - name: Build APK Release
        run: flutter build apk --release --android-skip-build-dependency-validation

      - name: Upload APK Artifact
        uses: actions/upload-artifact@v4
        with:
          name: app-release-apk
          path: build/app/outputs/flutter-apk/app-release.apk
```

### B. `android/settings.gradle`
```groovy
pluginManagement {
    def flutterSdkPath = {
        def properties = new Properties()
        file("local.properties").withInputStream { properties.load(it) }
        def flutterSdkPath = properties.getProperty("flutter.sdk")
        assert flutterSdkPath != null, "flutter.sdk not set in local.properties"
        return flutterSdkPath
    }()

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "8.5.2" apply false
    id "org.jetbrains.kotlin.android" version "1.9.24" apply false
}

include ":app"
```

### C. `android/gradle/wrapper/gradle-wrapper.properties`
```properties
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-8.7-all.zip
```

### D. `android/app/build.gradle`
```groovy
plugins {
    id "com.android.application"
    id "kotlin-android"
    id "dev.flutter.flutter-gradle-plugin"
}

android {
    namespace = "com.example.smk_puger_digital"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = "17"
    }

    defaultConfig {
        applicationId = "com.example.smk_puger_digital"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.debug
        }
    }
}

flutter {
    source = "../.."
}
```

### E. `android/build.gradle`
```groovy
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

rootProject.buildDir = "../build"
subprojects {
    project.buildDir = "${rootProject.buildDir}/${project.name}"
}

tasks.register("clean", Delete) {
    delete rootProject.buildDir
}
```

---

## 4. Cara Deploy & Mengunduh Hasil APK

1. **Kirim Perubahan ke GitHub**:
   ```bash
   git add -A
   git commit -m "Fix workflow issues: upgrade Gradle 8.4, AGP 8.3.2, Kotlin 1.9.24, and clean config"
   git push origin main
   ```
2. **Pantau Proses Build**:
   * Buka repositori di GitHub browser: `https://github.com/zerobugteam/SMKS-PUGER`
   * Klik tab **Actions**.
   * Klik workflow run terbaru `Build Flutter APK`.
3. **Unduh File APK**:
   * Setelah seluruh step bertanda centang hijau (Success), scroll ke bagian bawah halaman rincian run.
   * Pada bagian **Artifacts**, klik **`app-release-apk`** untuk mengunduh file `.zip` yang berisi file installer `app-release.apk`.
