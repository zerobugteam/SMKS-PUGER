class ApiService {
  // Isi alamat API setelah backend Laravel siap.
  // Contoh: static const String baseUrl = 'https://domain-sekolah.id/api';
  static const String baseUrl = '';

  Future<void> checkConnection() async {
    if (baseUrl.isEmpty) {
      throw StateError(
        'API belum dikonfigurasi. Aplikasi saat ini berjalan dalam mode demo.',
      );
    }
    // Implementasikan HTTP request dan penanganan token di tahap integrasi.
  }
}
