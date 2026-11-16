PAKET KODE LIB - SMK PUGER DIGITAL

Cara menggunakan:
1. Ekstrak folder lib dari ZIP.
2. Salin folder dan file di dalamnya ke folder lib proyek Flutter:
   C:\src\projects\smk_puger_digital\lib
3. Pilih Replace/Overwrite jika diminta.
4. Pastikan pubspec.yaml masih menggunakan Flutter SDK standar.
5. Jalankan:
   flutter clean
   flutter pub get
   flutter analyze
   flutter run -d chrome

Catatan:
- Ini adalah kerangka UI awal dengan halaman terpisah berdasarkan role.
- Login masih DEMO: username dan password apa saja yang tidak kosong diterima.
- Belum ada backend Laravel, database, token, data siswa, GPS, kamera, QRIS,
  pembayaran, atau koneksi API yang aktif.
- Halaman fitur individual saat ini berupa placeholder. Isi fitur sebenarnya
  akan dikembangkan per modul.
- Splash screen ditambahkan di pages/auth/splash_screen.dart.
- Folder test proyek tidak diubah.
