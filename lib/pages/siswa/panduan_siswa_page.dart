import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

typedef BabPanduan = Map<String, dynamic>;

class PanduanSiswaPage extends StatelessWidget {
  const PanduanSiswaPage({super.key});

  static const List<BabPanduan> _babJurnalPanduan = [
    {
      'kode': 'BAB I',
      'judul': 'PENDAHULUAN & TUJUAN SISTEM',
      'ringkasan':
          'Portal Akademik & PKL SMKS Puger Jember merupakan sistem informasi terpadu berbasis web dan perangkat bergerak yang dirancang untuk mendigitalisasi administrasi pembelajaran, presensi berbasis lokasi (geofencing), pemantauan nilai, serta tata kelola Praktik Kerja Lapangan (PKL).',
      'poin': [
        '1.1 Tujuan Operasional: Mewujudkan transparansi data akademik siswa, akurasi rekapitulasi kehadiran harian di sekolah maupun di industri, serta efisiensi pelaporan jurnal kegiatan (logbook) PKL secara real-time.',
        '1.2 Ruang Lingkup Pengguna: Pedoman ini berlaku bagi seluruh peserta didik aktif SMKS Puger Jember (Kelas X, XI, dan XII) di semua konsentrasi keahlian, termasuk Teknik Komputer dan Jaringan (TKJ).',
        '1.3 Persyaratan Teknis Perangkat: Perangkat smartphone (Android/iOS) atau komputer/laptop dengan browser modern (Google Chrome / Safari versi terbaru), koneksi internet stabil, sensor GPS/Lokasi aktif, serta izin akses kamera depan (WebRTC/Native Camera).',
      ],
    },
    {
      'kode': 'BAB II',
      'judul': 'MANAJEMEN PROFIL & KEAMANAN AKUN SISWA',
      'ringkasan':
          'Setiap peserta didik memperoleh kredensial unik berbasis Nomor Induk Siswa (NIS) dan email resmi institusi (@smk-puger.sch.id) yang wajib dijaga kerahasiaannya.',
      'poin': [
        '2.1 Verifikasi Identitas pada Dashboard: Setelah berhasil masuk (login), siswa wajib memeriksa kesesuaian Data Pribadi (NIK, Tempat/Tanggal Lahir, Nomor WhatsApp aktif, Alamat Domisili) serta Data Akademik (NIS/NISN, Kelas, Wali Kelas, dan Pembimbing PKL).',
        '2.2 Prosedur Pembaruan Kata Sandi (Menu Ganti Sandi): Demi keamanan data akademik, siswa diwajibkan mengganti kata sandi bawaan secara berkala melalui menu Ganti Sandi dengan memasukkan kata sandi lama dan menetapkan kata sandi baru minimal 6 karakter kombinasi huruf dan angka.',
        '2.3 Penanganan Lupa Kredensial: Apabila siswa lupa kata sandi atau menemukan ketidaksesuaian data NIK/NISN, siswa wajib melapor ke bagian Tata Usaha / Pusat Informasi dan Layanan Akademik SMKS Puger untuk proses reset dan sinkronisasi Dapodik.',
      ],
    },
    {
      'kode': 'BAB III',
      'judul': 'PROSEDUR PRESENSI HARIAN SEKOLAH (GEOFENCING & SELFIE)',
      'ringkasan':
          'Sistem presensi harian menerapkan validasi ganda berupa pembatasan radius koordinat geografis (Geofencing) dan verifikasi biometrik visual (Swafoto/Selfie langsung).',
      'poin': [
        '3.1 Parameter Koordinat & Radius Sekolah: Titik pusat presensi ditetapkan pada kampus SMKS Puger Jember (Krajan I, Kasiyan Tim., Kec. Puger, Kab. Jember 68164) dengan batas toleransi jarak maksimal 100 meter.',
        '3.2 Tahapan Absen Masuk & Absen Pulang: (a) Buka menu Absensi; (b) Pastikan indikator status lokasi berwarna hijau ("Dalam Area Sekolah"); (c) Ketuk tombol Kamera untuk membuka pratinjau kamera depan secara langsung dan ambil foto selfie wajah yang jelas; (d) Tekan tombol Absen Masuk saat tiba di sekolah dan Absen Pulang setelah jam kegiatan belajar selesai.',
        '3.3 Ketentuan Penolakan Sistem: Tombol presensi akan menolak pencatatan secara otomatis apabila jarak GPS melebihi 100 meter dari titik pusat sekolah atau apabila siswa belum melampirkan foto selfie terbaru.',
      ],
    },
    {
      'kode': 'BAB IV',
      'judul': 'TATA KELOLA PRAKTIK KERJA LAPANGAN (MAGANG / PKL)',
      'ringkasan':
          'Modul Magang / PKL terbagi menjadi dua tahapan terstruktur: tahap administratif pengajuan penempatan (Pendaftaran Magang) dan tahap operasional harian di industri (Pelaksanaan Magang).',
      'poin': [
        '4.1 Tahap Pendaftaran Magang (Sub-Menu Pendaftaran Magang): Siswa memilih perusahaan/instansi mitra industri SMKS Puger yang tersedia pada daftar (atau memilih opsi Input Manual untuk instansi baru), melakukan pencarian dan pemilihan Guru Pembimbing PKL, mengisi bidang/divisi penempatan serta periode gelombang PKL, lalu menekan Ajukan Pendaftaran.',
        '4.2 Verifikasi Pokja PKL: Setiap pengajuan akan berstatus "Menunggu Verifikasi" hingga disetujui oleh Kelompok Kerja (Pokja) PKL dan Guru Pembimbing yang ditunjuk.',
        '4.3 Presensi Lokasi Industri (Sub-Menu Pelaksanaan Magang): Selama masa PKL berlangsung, siswa wajib melakukan Absen Masuk PKL dan Absen Pulang PKL setiap hari kerja. Validasi GPS secara otomatis mengikuti titik koordinat perusahaan tempat siswa ditempatkan dengan batas radius 100 meter serta wajib menyertakan foto selfie di lokasi industri.',
        '4.4 Penyusunan Logbook Kegiatan Harian: Setiap hari kerja, siswa wajib mencatat uraian pekerjaan atau kompetensi praktik yang dilaksanakan melalui tombol Isi Jurnal pada bagian Logbook Kegiatan Harian agar dapat divalidasi oleh Guru Pembimbing maupun Pembimbing Industri.',
      ],
    },
    {
      'kode': 'BAB V',
      'judul': 'PEMANTAUAN NILAI SEMESTER & JADWAL PELAJARAN',
      'ringkasan':
          'Portal menyediakan akses transparan terhadap capaian evaluasi hasil belajar serta agenda perkuliahan/pembelajaran tatap muka.',
      'poin': [
        '5.1 Evaluasi Hasil Belajar (Menu Nilai Semester): Siswa dapat meninjau rincian nilai Ujian Tengah Semester (UTS/Sisipan), nilai akhir semester, predikat capaian kompetensi, serta keterangan ketuntasan setiap mata pelajaran.',
        '5.2 Agenda Akademik (Menu Jadwal Pelajaran): Menampilkan daftar mata pelajaran aktif per hari beserta alokasi jam pelajaran, nama guru pengampu, dan kode ruang kelas atau laboratorium praktik.',
      ],
    },
    {
      'kode': 'BAB VI',
      'judul': 'PENYELESAIAN KENDALA TEKNIS (TROUBLESHOOTING) & LAYANAN',
      'ringkasan':
          'Panduan penanganan mandiri apabila terjadi kendala teknis perangkat saat mengakses portal maupun saat melakukan presensi.',
      'poin': [
        '6.1 Kamera Tidak Muncul di Browser: Pastikan izin kamera (Camera Permission) pada ikon gembok di bilah alamat Google Chrome telah diatur ke "Izinkan / Allow", serta pastikan tidak ada aplikasi lain yang sedang menggunakan kamera.',
        '6.2 Titik GPS Tidak Akurat / Di Luar Radius: Aktifkan mode "Akurasi Tinggi / High Accuracy" pada pengaturan Lokasi HP, muat ulang halaman (Refresh), dan pastikan siswa berada di area terbuka di lingkungan sekolah atau lokasi industri.',
        '6.3 Pusat Bantuan & Layanan Akademik: Jika mengalami kendala sistem yang berkelanjutan, hubungi Pusat Informasi dan Layanan Akademik SMKS Puger (Krajan I, Kasiyan Tim., Kec. Puger, Kab. Jember 68164 • WA: +62 821-3995-6462 • Email: info@smk-puger.sch.id).',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Dokumen Resmi Bergaya Jurnal Akademik
                Container(
                  padding: const EdgeInsets.all(22.0),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0F294A),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'DOKUMEN PEDOMAN TEKNIS • SOP-SISWA-2026',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Jurnal Panduan Operasional Portal Akademik & Praktik Kerja Lapangan (PKL)',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'SMKS Puger Jember • Tahun Pelajaran 2026/2027 • Edisi Peserta Didik',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.muted,
                        ),
                      ),
                      const Divider(height: 24, color: AppColors.border),
                      const Text(
                        'Abstrak: Dokumen ini disusun sebagai acuan standar operasional bagi seluruh peserta didik SMKS Puger Jember dalam mengoperasikan Sistem Informasi Portal Siswa, meliputi pengelolaan identitas akademik, mekanisme presensi berbasis geofencing dan verifikasi foto selfie, prosedur pengajuan hingga pelaporan jurnal harian Praktik Kerja Lapangan (PKL), serta tata kelola keamanan akun.',
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: AppColors.text,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),

                // Daftar Bab Panduan Lengkap
                for (final bab in _babJurnalPanduan) ...[
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.only(bottom: 14.0),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(
                                  alpha: 0.12,
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                bab['kode'] as String,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primaryDark,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                bab['judul'] as String,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          bab['ringkasan'] as String,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.muted,
                            height: 1.45,
                          ),
                        ),
                        const Divider(height: 22, color: AppColors.border),
                        for (final poin in (bab['poin'] as List<String>))
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 6.0,
                                    right: 10.0,
                                  ),
                                  child: Icon(
                                    Icons.circle,
                                    size: 6,
                                    color: AppColors.primaryDark,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    poin,
                                    style: const TextStyle(
                                      fontSize: 13.5,
                                      color: AppColors.text,
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],

                // Catatan Penutup Jurnal
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Text(
                    'Disahkan oleh: Tim Kurikulum & Pokja PKL SMKS Puger Jember • Pembaruan Terakhir: November 2026',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.muted,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
