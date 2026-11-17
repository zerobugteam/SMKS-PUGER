<div align="center">

  <!-- Tech Badge Header -->
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Geolocator-4285F4?style=for-the-badge&logo=googlemaps&logoColor=white" alt="Geolocator">
  <img src="https://img.shields.io/badge/PDF-E34F26?style=for-the-badge&logo=adobeacrobatreader&logoColor=white" alt="PDF Generation">
  <img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white" alt="GitHub Actions">

  <br><br>

  <!-- Project Title -->
  <h1>🏫 SMKS Puger Digital</h1>

  <p><strong>Sistem Pendidikan Digital Terintegrasi untuk SMKS Perikanan dan Kelautan Puger</strong></p>

  <p>
    <img src="https://img.shields.io/badge/Version-1.0.0-blue?style=flat-square">
    <img src="https://img.shields.io/badge/Status-Active_Development-green?style=flat-square">
    <img src="https://img.shields.io/badge/License-MIT-yellow?style=flat-square">
  </p>

</div>

---

## 🚀 Tentang Project

**SMKS Puger Digital** adalah aplikasi multi-platform (Android, iOS, Web, Windows, macOS, Linux) yang dibangun menggunakan **Flutter**. Aplikasi ini dirancang sebagai solusi digitalisasi manajemen pendidikan yang komprehensif, menghubungkan siswa, guru, dan administrasi sekolah dalam satu ekosistem yang terintegrasi.

Sistem ini menghadirkan fitur-fitur krusial seperti absensi berbasis lokasi (Geofencing), pengumpulan tugas digital, hingga pencetakan laporan dan rapor langsung dalam format PDF. Dibangun dengan arsitektur yang bersih (*clean architecture*) dan CI/CD menggunakan GitHub Actions untuk memastikan kualitas kode dan deployment yang andal.

Cocok untuk:
- 📍 Absensi siswa & guru berbasis validasi lokasi (Geolocator)
- 📚 Manajemen tugas, materi, dan pengumpulan karya digital
- 📊 Input nilai dan penilaian oleh guru secara real-time
- 🖨️ Generate dan cetak dokumen resmi (Rapor, Surat Keterangan) via PDF
- 🔄 Sinkronisasi data multi-platform (Mobile & Web)

---

## ✨ Fitur Utama

| Fitur | Deskripsi |
|-------|-----------|
| 📍 **Absensi Berbasis Lokasi** | Validasi kehadiran menggunakan `geolocator` untuk memastikan siswa/guru berada di area sekolah (Geofencing) |
| 📚 **Manajemen Tugas Digital** | Unggah dan unduh tugas, materi pelajaran, dan dokumen pendukung menggunakan `file_picker` & `image_picker` |
| 📊 **Dashboard Guru & Siswa** | Antarmuka khusus: Guru untuk input nilai & tugas, Siswa untuk melihat jadwal, tugas, dan perkembangan akademik |
| 🖨️ **PDF Generator & Printing** | Fitur ekspor dan cetak dokumen resmi (laporan kehadiran, rapor sementara, surat tugas) langsung dari aplikasi |
| 🔐 **Autentikasi & Keamanan** | Sistem login terenkripsi dengan manajemen role (Admin, Guru, Siswa) yang ketat |
| 🚀 **CI/CD Pipeline** | Integrasi GitHub Actions untuk automated testing, formatting check, dan build preparation |
| 📱 **Multi-Platform Support** | Satu codebase untuk Android, iOS, Web, Windows, macOS, dan Linux |
| 🎨 **Modern UI/UX** | Desain antarmuka yang responsif, intuitif, dan mengikuti pedoman Material Design 3 |

---

## 🛠️ Tech Stack

| Layer | Teknologi |
|-------|-----------|
| **Framework** | Flutter (SDK >= 3.0.0) |
| **Bahasa Pemrograman** | Dart |
| **State Management** | *(Sesuaikan: misal Provider / Riverpod / GetX)* |
| **Lokasi & Maps** | `geolocator` ^13.0.2 |
| **File & Media** | `image_picker` ^1.1.2, `file_picker` ^8.1.4 |
| **Dokumen** | `pdf` ^3.11.0, `printing` ^5.13.0 |
| **CI/CD** | GitHub Actions (YAML Workflows) |
| **Version Control** | Git & GitHub |

---

## 📂 Struktur Folder
