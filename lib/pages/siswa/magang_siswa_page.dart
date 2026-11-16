import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_colors.dart';
import 'web_camera_dialog.dart';

typedef LogbookItem = Map<String, String>;
typedef PengajuanItem = Map<String, String>;
typedef MitraMagang = Map<String, dynamic>;
typedef GuruPembimbing = Map<String, String>;

class MagangPage extends StatefulWidget {
  final int initialTab; // 0 = Pelaksanaan Magang, 1 = Pendaftaran Magang
  const MagangPage({super.key, this.initialTab = 0});

  @override
  State<MagangPage> createState() => _MagangPageState();
}

class _MagangPageState extends State<MagangPage> {
  late final int _activeTab = widget.initialTab;

  final TextEditingController _kegiatanCtrl = TextEditingController();
  final TextEditingController _perusahaanManualCtrl = TextEditingController();
  final TextEditingController _divisiCtrl = TextEditingController(
    text: 'Teknik Komputer & Jaringan (TKJ)',
  );
  final TextEditingController _alamatCtrl = TextEditingController();

  String _selectedMitra = 'PT Sinovasi Idea Karya Jember';
  String _selectedGuruPembimbing = 'Lalitya Nindita Sahenda, S.Pd.';
  String _selectedPeriode = '01 Apr 2027 – 30 Sep 2027 (Gelombang 2)';

  // --- State Pembayaran Administrasi PKL ---
  String _metodeBayarPkl = 'Transfer Bank Jatim (No. Rek: 0032948120)';
  String? _namaFileBuktiBayarPkl;

  static const List<String> _opsiMetodeBayarPkl = [
    'Transfer Bank Jatim (No. Rek: 0032948120)',
    'Transfer BRI Virtual Account SMKS Puger',
    'Bayar Tunai di Loket Tata Usaha Sekolah',
  ];

  static const List<MitraMagang> _daftarMitra = [
    {
      'nama': 'PT Sinovasi Idea Karya Jember',
      'alamat': 'Sumbersari, Kab. Jember, Jawa Timur',
      'lat': -8.172400,
      'lng': 113.702100,
    },
    {
      'nama': 'PT Telkom Indonesia Witel Jember',
      'alamat': 'Jl. Gajah Mada No.182, Kaliwates, Jember',
      'lat': -8.174800,
      'lng': 113.688900,
    },
    {
      'nama': 'Diskominfo Kabupaten Jember',
      'alamat': 'Jl. Nusantara No.2, Kaliwates, Jember',
      'lat': -8.173100,
      'lng': 113.691500,
    },
    {
      'nama': 'CV Solusi Jaringan Nusantara (Jember)',
      'alamat': 'Patrang, Kab. Jember, Jawa Timur',
      'lat': -8.158900,
      'lng': 113.706400,
    },
    {
      'nama': 'Lainnya (Input Manual)',
      'alamat': 'Lokasi Magang Mandiri (Jember)',
      'lat': -8.172400,
      'lng': 113.702100,
    },
  ];

  static const List<GuruPembimbing> _daftarGuruPembimbing = [
    {
      'nama': 'Lalitya Nindita Sahenda, S.Pd.',
      'nip': 'NIP. 19940312 202012 2 014',
      'keahlian': 'Teknik Komputer dan Jaringan (TKJ)',
    },
    {
      'nama': 'Yogiswara, S.T., Gr.',
      'nip': 'NIP. 19890718 201801 1 006',
      'keahlian': 'Teknik Komputer dan Jaringan (TKJ)',
    },
    {
      'nama': 'Ahmad Fauzi, S.Kom.',
      'nip': 'NIP. 19911105 201903 1 009',
      'keahlian': 'Rekayasa Perangkat Lunak & Jaringan',
    },
    {
      'nama': 'Siti Rahmawati, S.Pd.',
      'nip': 'NIP. 19930522 202012 2 011',
      'keahlian': 'Sistem Informasi & Administrasi Jaringan',
    },
    {
      'nama': 'Bambang Sutrisno, S.T.',
      'nip': 'NIP. 19850814 201406 1 003',
      'keahlian': 'Infrastruktur Jaringan & Server',
    },
    {
      'nama': 'Dewi Lestari, S.Kom., M.Pd.',
      'nip': 'NIP. 19881202 201504 2 002',
      'keahlian': 'Keamanan Jaringan & Cloud',
    },
  ];

  static const List<String> _daftarPeriode = [
    '01 Okt 2026 – 31 Mar 2027 (Gelombang 1)',
    '01 Apr 2027 – 30 Sep 2027 (Gelombang 2)',
  ];

  String _aktifPerusahaan = 'PT Sinovasi Idea Karya Jember';
  String _aktifAlamat = 'Sumbersari, Kab. Jember, Jawa Timur';
  String _aktifGuruPembimbing = 'Lalitya Nindita Sahenda, S.Pd.';
  double _magangLat = -8.172400;
  double _magangLng = 113.702100;
  static const double _maxRadiusMagang = 100.0;

  double _currentLat = -8.172550;
  double _currentLng = 113.702220;

  final ImagePicker _picker = ImagePicker();
  Uint8List? _fotoSelfieBytes;
  String _jamMasukMagang = '-';
  String _jamPulangMagang = '-';

  final List<LogbookItem> _logbookHarian = [
    {
      'tanggal': 'Senin, 16 Nov 2026',
      'kegiatan':
          'Konfigurasi Mikrotik RouterBoard & manajemen bandwidth jaringan kantor.',
      'status': 'Disetujui',
    },
    {
      'tanggal': 'Jumat, 13 Nov 2026',
      'kegiatan':
          'Crimping kabel UTP Cat6 dan pengecekan titik akses Wi-Fi lantai 2.',
      'status': 'Disetujui',
    },
    {
      'tanggal': 'Kamis, 12 Nov 2026',
      'kegiatan': 'Instalasi sistem operasi Linux Server dan setup SSH lokal.',
      'status': 'Disetujui',
    },
  ];

  final List<PengajuanItem> _riwayatPengajuan = [
    {
      'perusahaan': 'PT Sinovasi Idea Karya Jember',
      'divisi': 'IT Infrastructure & Network Engineering',
      'pembimbing': 'Lalitya Nindita Sahenda, S.Pd.',
      'periode': '01 Okt 2026 – 31 Mar 2027 (Gelombang 1)',
      'pembayaran': 'Lunas • Rp 350.000 (Transfer Bank Jatim)',
      'status': 'Disetujui',
    },
  ];

  @override
  void dispose() {
    _kegiatanCtrl.dispose();
    _perusahaanManualCtrl.dispose();
    _divisiCtrl.dispose();
    _alamatCtrl.dispose();
    super.dispose();
  }

  Future<void> _pilihBuktiBayarPkl() async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (file == null) return;
      if (!mounted) return;
      setState(() => _namaFileBuktiBayarPkl = file.name);
      _showSnack('Bukti pembayaran PKL (${file.name}) terlampir.');
    } catch (_) {
      if (!mounted) return;
      _showSnack('Gagal memilih file bukti pembayaran.', isError: true);
    }
  }

  void _bukaPencarianGuruPembimbing() {
    String keyword = '';

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final query = keyword.trim().toLowerCase();
            final hasilFilter = _daftarGuruPembimbing.where((guru) {
              final nama = (guru['nama'] ?? '').toLowerCase();
              final nip = (guru['nip'] ?? '').toLowerCase();
              final keahlian = (guru['keahlian'] ?? '').toLowerCase();
              return nama.contains(query) ||
                  nip.contains(query) ||
                  keahlian.contains(query);
            }).toList();

            return AlertDialog(
              backgroundColor: AppColors.surface,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              title: const Text(
                'Pilih Guru Pembimbing PKL',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
              ),
              content: SizedBox(
                width: 440,
                height: 360,
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      onChanged: (val) => setDialogState(() => keyword = val),
                      decoration: InputDecoration(
                        hintText: 'Cari nama guru, NIP, atau keahlian...',
                        hintStyle: const TextStyle(
                          fontSize: 13,
                          color: AppColors.muted,
                        ),
                        prefixIcon: const Icon(Icons.search_rounded, size: 20),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: hasilFilter.isEmpty
                          ? const Center(
                              child: Text(
                                'Guru pembimbing tidak ditemukan.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.muted,
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemCount: hasilFilter.length,
                              separatorBuilder: (_, __) => const Divider(
                                height: 1,
                                color: AppColors.border,
                              ),
                              itemBuilder: (context, index) {
                                final guru = hasilFilter[index];
                                final nama = guru['nama'] ?? '';
                                final isSelected =
                                    nama == _selectedGuruPembimbing;

                                return ListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 2,
                                  ),
                                  leading: CircleAvatar(
                                    radius: 17,
                                    backgroundColor: isSelected
                                        ? AppColors.primary
                                        : AppColors.background,
                                    child: Icon(
                                      Icons.person_outline_rounded,
                                      size: 18,
                                      color: isSelected
                                          ? Colors.white
                                          : AppColors.muted,
                                    ),
                                  ),
                                  title: Text(
                                    nama,
                                    style: TextStyle(
                                      fontSize: 13.5,
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w600,
                                      color: AppColors.text,
                                    ),
                                  ),
                                  subtitle: Text(
                                    '${guru['keahlian']} • ${guru['nip']}',
                                    style: const TextStyle(
                                      fontSize: 11.5,
                                      color: AppColors.muted,
                                    ),
                                  ),
                                  trailing: isSelected
                                      ? const Icon(
                                          Icons.check_circle_rounded,
                                          color: AppColors.success,
                                          size: 20,
                                        )
                                      : null,
                                  onTap: () {
                                    setState(
                                      () => _selectedGuruPembimbing = nama,
                                    );
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Tutup'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  double get _jarakKeLokasiMagang {
    const double r = 6371000;
    final dLat = (_currentLat - _magangLat) * (pi / 180);
    final dLon = (_currentLng - _magangLng) * (pi / 180);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_magangLat * (pi / 180)) *
            cos(_currentLat * (pi / 180)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    return r * 2 * atan2(sqrt(a), sqrt(1 - a));
  }

  bool get _dalamAreaMagang => _jarakKeLokasiMagang <= _maxRadiusMagang;

  void _ubahSimulasiLokasiMagang(bool dalamLokasi) {
    setState(() {
      if (dalamLokasi) {
        _currentLat = _magangLat + 0.00015;
        _currentLng = _magangLng + 0.00012;
      } else {
        _currentLat = _magangLat + 0.00350;
        _currentLng = _magangLng + 0.00200;
      }
    });
  }

  Future<void> _bukaKameraSelfieMagang() async {
    if (kIsWeb) {
      final Uint8List? hasilFoto = await showDialog<Uint8List>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const WebCameraDialog(),
      );

      if (hasilFoto != null && mounted) {
        setState(() => _fotoSelfieBytes = hasilFoto);
        _showSnack('Foto selfie absensi PKL berhasil diambil.');
      }
      return;
    }

    try {
      final XFile? foto = await _picker.pickImage(
        source: ImageSource.camera,
        preferredCameraDevice: CameraDevice.front,
        imageQuality: 70,
        maxWidth: 800,
      );

      if (foto == null) return;
      final bytes = await foto.readAsBytes();
      if (!mounted) return;

      setState(() => _fotoSelfieBytes = bytes);
      _showSnack('Foto selfie absensi PKL berhasil diambil.');
    } catch (e) {
      if (!mounted) return;
      _showSnack(
        'Gagal membuka kamera: pastikan izin kamera aktif.',
        isError: true,
      );
    }
  }

  void _catatkanAbsenMagang(bool isMasuk) {
    if (!_dalamAreaMagang) {
      _showSnack(
        'Gagal: Anda berada di luar radius 100m $_aktifPerusahaan.',
        isError: true,
      );
      return;
    }
    if (_fotoSelfieBytes == null) {
      _showSnack(
        'Ambil foto selfie di lokasi PKL terlebih dahulu.',
        isError: true,
      );
      return;
    }

    final now = TimeOfDay.now();
    final jam =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} WIB';

    setState(() {
      if (isMasuk) {
        _jamMasukMagang = jam;
        _fotoSelfieBytes = null;
      } else {
        _jamPulangMagang = jam;
      }
    });

    _showSnack(
      isMasuk
          ? 'Absen Masuk PKL tercatat ($jam).'
          : 'Absen Pulang PKL tercatat ($jam).',
    );
  }

  void _tambahLogbookDialog() {
    _kegiatanCtrl.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          title: const Text(
            'Catat Kegiatan PKL Hari Ini',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
          content: SizedBox(
            width: 420,
            child: TextField(
              controller: _kegiatanCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Tuliskan pekerjaan atau praktik yang dilakukan...',
                hintStyle: const TextStyle(
                  fontSize: 13,
                  color: AppColors.muted,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            FilledButton(
              onPressed: () {
                final teks = _kegiatanCtrl.text.trim();
                if (teks.isEmpty) return;
                setState(() {
                  _logbookHarian.insert(0, {
                    'tanggal': 'Hari Ini • 16 Nov 2026',
                    'kegiatan': teks,
                    'status': 'Menunggu Validasi',
                  });
                });
                Navigator.pop(context);
                _showSnack('Jurnal kegiatan PKL berhasil disimpan.');
              },
              style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _kirimPendaftaran() {
    final isManual = _selectedMitra == 'Lainnya (Input Manual)';
    final namaPerusahaan =
        isManual ? _perusahaanManualCtrl.text.trim() : _selectedMitra;

    if (namaPerusahaan.isEmpty) {
      _showSnack(
        'Masukkan nama perusahaan tujuan terlebih dahulu.',
        isError: true,
      );
      return;
    }

    final isTunai = _metodeBayarPkl.contains('Tunai');
    if (!isTunai && _namaFileBuktiBayarPkl == null) {
      _showSnack(
        'Unggah bukti pembayaran administrasi PKL terlebih dahulu.',
        isError: true,
      );
      return;
    }

    final mitraData = _daftarMitra.firstWhere(
      (m) => m['nama'] == _selectedMitra,
      orElse: () => _daftarMitra.first,
    );

    final infoBayar = isTunai
        ? 'Bayar Tunai TU • Rp 350.000'
        : 'Rp 350.000 • Bukti: $_namaFileBuktiBayarPkl';

    setState(() {
      _riwayatPengajuan.insert(0, {
        'perusahaan': namaPerusahaan,
        'divisi': _divisiCtrl.text.trim().isEmpty
            ? 'Divisi IT & Jaringan'
            : _divisiCtrl.text.trim(),
        'pembimbing': _selectedGuruPembimbing,
        'periode': _selectedPeriode,
        'pembayaran': infoBayar,
        'status': 'Menunggu Verifikasi',
      });

      _aktifPerusahaan = namaPerusahaan;
      _aktifAlamat = _alamatCtrl.text.trim().isNotEmpty
          ? _alamatCtrl.text.trim()
          : (mitraData['alamat'] as String);
      _aktifGuruPembimbing = _selectedGuruPembimbing;
      _magangLat = mitraData['lat'] as double;
      _magangLng = mitraData['lng'] as double;
      _currentLat = _magangLat + 0.00015;
      _currentLng = _magangLng + 0.00012;

      _perusahaanManualCtrl.clear();
      _alamatCtrl.clear();
      _namaFileBuktiBayarPkl = null;
    });

    _showSnack('Pendaftaran & pembayaran PKL berhasil dikirim ke Pokja PKL.');
  }

  void _showSnack(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? AppColors.danger : AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPendaftaran = _activeTab == 1;

    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  isPendaftaran
                      ? 'Pendaftaran & Pembayaran Magang / PKL'
                      : 'Pelaksanaan Magang / PKL',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isPendaftaran
                      ? 'Pengajuan tempat PKL, guru pembimbing, serta administrasi pembayaran PKL'
                      : 'Absensi lokasi industri, informasi PKL, dan logbook harian',
                  style: const TextStyle(fontSize: 13, color: AppColors.muted),
                ),
                const SizedBox(height: 18),
                if (isPendaftaran)
                  _buildPendaftaranSection()
                else
                  _buildPelaksanaanSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // TAMPILAN 1: PELAKSANAAN MAGANG
  // =========================================================================
  Widget _buildPelaksanaanSection() {
    final inArea = _dalamAreaMagang;
    final jarak = _jarakKeLokasiMagang.toStringAsFixed(0);
    final sudahSelfie = _fotoSelfieBytes != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
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
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.business_rounded,
                      color: AppColors.primaryDark,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _aktifPerusahaan,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _aktifAlamat,
                          style: const TextStyle(
                            fontSize: 12.5,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.success.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Sedang Berjalan',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 24, color: AppColors.border),
              Wrap(
                spacing: 28,
                runSpacing: 12,
                children: [
                  _infoItem('Guru Pembimbing PKL', _aktifGuruPembimbing),
                  _infoItem('Pembimbing Industri', 'Rizky Pratama, S.Kom.'),
                  _infoItem(
                    'Titik Koordinat PKL',
                    '${_magangLat.toStringAsFixed(5)}, ${_magangLng.toStringAsFixed(5)}',
                  ),
                  _infoItem('Kehadiran PKL', '36 / 120 Hari (30%)'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Absensi Lokasi Magang
        Container(
          padding: const EdgeInsets.all(18.0),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: inArea ? AppColors.success : AppColors.danger,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Icon(
                    inArea ? Icons.location_on : Icons.location_off,
                    color: inArea ? AppColors.success : AppColors.danger,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      inArea
                          ? 'Absensi PKL: Dalam Area $_aktifPerusahaan ($jarak m)'
                          : 'Absensi PKL: Di Luar Area Lokasi PKL ($jarak m — Maks 100 m)',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                        color: inArea ? AppColors.success : AppColors.danger,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  TextButton(
                    onPressed: () => _ubahSimulasiLokasiMagang(true),
                    child: const Text(
                      'Tes Dalam Area PKL',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  TextButton(
                    onPressed: () => _ubahSimulasiLokasiMagang(false),
                    child: const Text(
                      'Tes Luar Area PKL',
                      style: TextStyle(fontSize: 12, color: AppColors.danger),
                    ),
                  ),
                ],
              ),
              const Divider(height: 18, color: AppColors.border),
              Row(
                children: [
                  InkWell(
                    onTap: _bukaKameraSelfieMagang,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: 66,
                      height: 66,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: sudahSelfie
                              ? AppColors.success
                              : AppColors.border,
                        ),
                      ),
                      child: sudahSelfie
                          ? Image.memory(_fotoSelfieBytes!, fit: BoxFit.cover)
                          : const Icon(
                              Icons.camera_alt_outlined,
                              color: AppColors.muted,
                              size: 26,
                            ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          sudahSelfie
                              ? 'Foto selfie lokasi PKL siap'
                              : 'Selfie Kehadiran di Tempat Magang',
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          sudahSelfie
                              ? 'Ketuk foto untuk mengulang kamera.'
                              : 'Ambil foto selfie langsung saat tiba/pulang PKL.',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: _bukaKameraSelfieMagang,
                    icon: const Icon(Icons.camera_front_rounded, size: 18),
                    label: Text(sudahSelfie ? 'Ulang' : 'Kamera'),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: _jamMasukMagang != '-'
                          ? null
                          : () => _catatkanAbsenMagang(true),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                      ),
                      child: Text(
                        _jamMasukMagang == '-'
                            ? 'Absen Masuk PKL'
                            : 'Masuk: $_jamMasukMagang',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton(
                      onPressed:
                          (_jamMasukMagang == '-' || _jamPulangMagang != '-')
                              ? null
                              : () => _catatkanAbsenMagang(false),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.secondary,
                      ),
                      child: Text(
                        _jamPulangMagang == '-'
                            ? 'Absen Pulang PKL'
                            : 'Pulang: $_jamPulangMagang',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Logbook Harian
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 18,
                ),
                color: const Color(0xFFF8F9FA),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Logbook Kegiatan Harian',
                      style: TextStyle(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: _tambahLogbookDialog,
                      icon: const Icon(Icons.edit_note_rounded, size: 18),
                      label: const Text('Isi Jurnal'),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: AppColors.border),
              for (final item in _logbookHarian) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 18,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['tanggal'] ?? '',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              item['kegiatan'] ?? '',
                              style: const TextStyle(
                                fontSize: 13.5,
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item['status'] ?? '',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: item['status'] == 'Disetujui'
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.border),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // TAMPILAN 2: PENDAFTARAN MAGANG + PEMBAYARAN ADMINISTRASI PKL
  // =========================================================================
  Widget _buildPendaftaranSection() {
    final isManual = _selectedMitra == 'Lainnya (Input Manual)';
    final isTunai = _metodeBayarPkl.contains('Tunai');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Formulir Pengajuan Tempat & Pembayaran PKL',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const Divider(height: 22, color: AppColors.border),

              // 1. Perusahaan / Instansi Mitra
              const Text(
                'Perusahaan / Instansi Mitra',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _selectedMitra,
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 11,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: _daftarMitra
                    .map(
                      (mitra) => DropdownMenuItem<String>(
                        value: mitra['nama'] as String,
                        child: Text(
                          mitra['nama'] as String,
                          style: const TextStyle(fontSize: 13.5),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedMitra = val);
                },
              ),

              if (isManual) ...[
                const SizedBox(height: 12),
                TextField(
                  controller: _perusahaanManualCtrl,
                  decoration: InputDecoration(
                    labelText: 'Nama Perusahaan / Instansi Baru',
                    labelStyle: const TextStyle(fontSize: 13),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],

              // 2. Guru Pembimbing PKL (Searchable)
              const SizedBox(height: 12),
              const Text(
                'Guru Pembimbing PKL',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 6),
              InkWell(
                onTap: _bukaPencarianGuruPembimbing,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade500),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.person_search_rounded,
                        size: 20,
                        color: AppColors.primaryDark,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          _selectedGuruPembimbing,
                          style: const TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
                          ),
                        ),
                      ),
                      const Text(
                        'Cari / Ubah',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: AppColors.muted,
                      ),
                    ],
                  ),
                ),
              ),

              // 3. Bidang / Divisi
              const SizedBox(height: 12),
              TextField(
                controller: _divisiCtrl,
                decoration: InputDecoration(
                  labelText: 'Bidang / Divisi Penempatan',
                  labelStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // 4. Periode Pelaksanaan
              const SizedBox(height: 12),
              const Text(
                'Periode Pelaksanaan',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _selectedPeriode,
                isExpanded: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 11,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: _daftarPeriode
                    .map(
                      (p) => DropdownMenuItem(
                        value: p,
                        child: Text(p, style: const TextStyle(fontSize: 13.5)),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedPeriode = val);
                },
              ),

              // 5. Alamat Lokasi
              const SizedBox(height: 12),
              TextField(
                controller: _alamatCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Alamat Lokasi / Catatan (Opsional)',
                  labelStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // 6. Rincian Pembayaran Administrasi PKL
              const Divider(height: 28, color: AppColors.border),
              Container(
                padding: const EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Biaya Administrasi & Monitoring PKL',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                        Text(
                          'Rp 350.000',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Mencakup buku jurnal PKL, asuransi perlindungan kerja, dan pembimbingan industri.',
                      style: TextStyle(fontSize: 11.5, color: AppColors.muted),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Metode Pembayaran PKL',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.muted,
                      ),
                    ),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: _metodeBayarPkl,
                      isExpanded: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      items: _opsiMetodeBayarPkl
                          .map(
                            (m) => DropdownMenuItem(
                              value: m,
                              child: Text(
                                m,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _metodeBayarPkl = val);
                      },
                    ),
                    if (!isTunai) ...[
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: _pilihBuktiBayarPkl,
                            icon: const Icon(
                              Icons.upload_file_rounded,
                              size: 18,
                            ),
                            label: Text(
                              _namaFileBuktiBayarPkl == null
                                  ? 'Upload Bukti Transfer'
                                  : 'Ganti Bukti',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _namaFileBuktiBayarPkl ??
                                  'Belum ada file bukti transfer (JPG/PNG)',
                              style: TextStyle(
                                fontSize: 12,
                                color: _namaFileBuktiBayarPkl != null
                                    ? AppColors.success
                                    : AppColors.muted,
                                fontWeight: _namaFileBuktiBayarPkl != null
                                    ? FontWeight.w600
                                    : FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: _kirimPendaftaran,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(Icons.send_rounded, size: 17),
                  label: const Text('Ajukan Pendaftaran & Pembayaran'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Riwayat Status Pengajuan
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 18,
                ),
                color: const Color(0xFFF8F9FA),
                child: const Text(
                  'Status Pengajuan & Pembayaran PKL',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
              ),
              const Divider(height: 1, color: AppColors.border),
              for (final item in _riwayatPengajuan) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 18,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['perusahaan'] ?? '',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.text,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${item['divisi']}  •  ${item['periode']}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.muted,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Guru Pembimbing: ${item['pembimbing'] ?? '-'}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Pembayaran: ${item['pembayaran'] ?? '-'}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.text,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        item['status'] ?? '',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          color: item['status'] == 'Disetujui'
                              ? AppColors.success
                              : AppColors.warning,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: AppColors.border),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11.5, color: AppColors.muted),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          ),
        ),
      ],
    );
  }
}
