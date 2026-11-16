import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_colors.dart';
import '../siswa/web_camera_dialog.dart'; // Path diperbarui ke folder siswa

typedef RiwayatItem = Map<String, String>;

class AbsensiGuruPage extends StatefulWidget {
  const AbsensiGuruPage({super.key});

  @override
  State<AbsensiGuruPage> createState() => _AbsensiGuruPageState();
}

class _AbsensiGuruPageState extends State<AbsensiGuruPage> {
  static const double _schoolLat = -8.358500;
  static const double _schoolLng = 113.479200;
  static const double _maxRadius = 100.0;

  double _currentLat = -8.358680;
  double _currentLng = 113.479350;
  bool _isGpsLoading = false;
  String _gpsStatusText = 'Belum terhubung ke GPS perangkat';

  final ImagePicker _picker = ImagePicker();
  Uint8List? _fotoSelfieBytes;
  String _jamMasuk = '-';
  String _jamPulang = '-';

  final List<RiwayatItem> _riwayat = [
    {
      'tanggal': 'Jumat, 13 Nov 2026',
      'jam': '06:30 - 15:00 WIB',
      'status': 'Hadir',
    },
    {
      'tanggal': 'Kamis, 12 Nov 2026',
      'jam': '06:35 - 15:10 WIB',
      'status': 'Hadir',
    },
    {
      'tanggal': 'Rabu, 11 Nov 2026',
      'jam': '06:28 - 15:00 WIB',
      'status': 'Hadir',
    },
  ];

  @override
  void initState() {
    super.initState();
    _ambilLokasiGpsAsli();
  }

  Future<void> _ambilLokasiGpsAsli() async {
    setState(() {
      _isGpsLoading = true;
      _gpsStatusText = 'Mengakses sensor GPS perangkat...';
    });

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isGpsLoading = false;
          _gpsStatusText = 'Layanan GPS / Lokasi tidak aktif pada perangkat.';
        });
        _pesan(
            'GPS tidak aktif. Mohon aktifkan lokasi Anda.', AppColors.warning);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _isGpsLoading = false;
            _gpsStatusText = 'Izin akses lokasi ditolak.';
          });
          _pesan('Izin akses lokasi ditolak oleh pengguna.', AppColors.danger);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _isGpsLoading = false;
          _gpsStatusText = 'Izin lokasi ditolak secara permanen.';
        });
        _pesan('Izin lokasi ditolak permanen di pengaturan perangkat.',
            AppColors.danger);
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (!mounted) return;

      setState(() {
        _currentLat = position.latitude;
        _currentLng = position.longitude;
        _isGpsLoading = false;
        _gpsStatusText =
            'GPS Aktif (${position.latitude.toStringAsFixed(5)}, ${position.longitude.toStringAsFixed(5)})';
      });

      _pesan('Lokasi GPS berhasil diperbarui.', AppColors.success);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isGpsLoading = false;
        _gpsStatusText = 'Gagal membaca GPS: menggunakan simulasi.';
      });
      _pesan('Gagal mendapatkan koordinat GPS.', AppColors.danger);
    }
  }

  double get _jarakMeter {
    const double r = 6371000;
    final dLat = (_currentLat - _schoolLat) * (pi / 180);
    final dLon = (_currentLng - _schoolLng) * (pi / 180);
    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_schoolLat * (pi / 180)) *
            cos(_currentLat * (pi / 180)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    return r * 2 * atan2(sqrt(a), sqrt(1 - a));
  }

  bool get _dalamArea => _jarakMeter <= _maxRadius;

  void _ubahSimulasi(bool dalamSekolah) {
    setState(() {
      _currentLat = dalamSekolah ? -8.358680 : -8.362100;
      _currentLng = dalamSekolah ? 113.479350 : 113.480500;
      _gpsStatusText = dalamSekolah
          ? 'Mode Simulasi: Dalam Sekolah'
          : 'Mode Simulasi: Luar Sekolah';
    });
  }

  Future<void> _bukaKameraSelfie() async {
    if (kIsWeb) {
      final Uint8List? hasilFoto = await showDialog<Uint8List>(
        context: context,
        barrierDismissible: false,
        builder: (_) => const WebCameraDialog(),
      );

      if (hasilFoto != null && mounted) {
        setState(() => _fotoSelfieBytes = hasilFoto);
        _pesan('Foto selfie berhasil diambil.', AppColors.success);
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
      _pesan('Foto selfie berhasil diambil.', AppColors.success);
    } catch (e) {
      if (!mounted) return;
      _pesan('Gagal membuka kamera: pastikan izin kamera aktif.',
          AppColors.danger);
    }
  }

  void _catatkanAbsen(bool isMasuk) {
    if (!_dalamArea) {
      _pesan('Gagal: Anda berada di luar radius 100m SMKS Puger.',
          AppColors.danger);
      return;
    }
    if (_fotoSelfieBytes == null) {
      _pesan('Ambil foto selfie terlebih dahulu.', AppColors.warning);
      return;
    }

    final now = TimeOfDay.now();
    final jam =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')} WIB';

    setState(() {
      if (isMasuk) {
        _jamMasuk = jam;
        _fotoSelfieBytes = null;
      } else {
        _jamPulang = jam;
      }
    });
    _pesan(
      isMasuk
          ? 'Absen Masuk Guru tercatat ($jam).'
          : 'Absen Pulang Guru tercatat ($jam).',
      AppColors.success,
    );
  }

  void _pesan(String teks, Color warna) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(teks),
        backgroundColor: warna,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inArea = _dalamArea;
    final jarak = _jarakMeter.toStringAsFixed(0);
    final sudahSelfie = _fotoSelfieBytes != null;

    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Absensi Guru & Pendidik',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Yogiswara, S.T., Gr. • Guru Produktif TKJ • SMKS Puger',
                  style: TextStyle(fontSize: 13, color: AppColors.muted),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: inArea ? AppColors.success : AppColors.danger,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            inArea ? Icons.location_on : Icons.location_off,
                            color:
                                inArea ? AppColors.success : AppColors.danger,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              inArea
                                  ? 'Dalam Area Sekolah ($jarak m dari pusat)'
                                  : 'Di Luar Area Sekolah ($jarak m — Maks 100 m)',
                              style: TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: inArea
                                    ? AppColors.success
                                    : AppColors.danger,
                              ),
                            ),
                          ),
                          if (_isGpsLoading)
                            const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          else
                            IconButton(
                              icon: const Icon(Icons.my_location,
                                  size: 20, color: AppColors.primary),
                              tooltip: 'Ambil Lokasi GPS Terbaru',
                              onPressed: _ambilLokasiGpsAsli,
                            ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _gpsStatusText,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.text),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        'Lat: -8.358500, Lng: 113.479200 (SMKS Puger)',
                        style:
                            TextStyle(fontSize: 11.5, color: AppColors.muted),
                      ),
                      const Divider(height: 16, color: AppColors.border),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Simulasi Uji Coba:',
                            style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: AppColors.muted),
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () => _ubahSimulasi(true),
                                child: const Text('Simulasi Masuk',
                                    style: TextStyle(fontSize: 11.5)),
                              ),
                              TextButton(
                                onPressed: () => _ubahSimulasi(false),
                                child: const Text(
                                  'Simulasi Luar',
                                  style: TextStyle(
                                      fontSize: 11.5, color: AppColors.danger),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: _bukaKameraSelfie,
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              width: 72,
                              height: 72,
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
                                  ? Image.memory(_fotoSelfieBytes!,
                                      fit: BoxFit.cover)
                                  : const Icon(
                                      Icons.camera_alt_outlined,
                                      color: AppColors.muted,
                                      size: 28,
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
                                      ? 'Foto selfie terlampir'
                                      : 'Foto Selfie Kehadiran Guru',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.text,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Ketuk tombol untuk membuka kamera depan.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.muted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          OutlinedButton.icon(
                            onPressed: _bukaKameraSelfie,
                            icon: const Icon(Icons.camera_front_rounded,
                                size: 18),
                            label: Text(sudahSelfie ? 'Ulang' : 'Kamera'),
                          ),
                        ],
                      ),
                      const Divider(height: 24, color: AppColors.border),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton(
                              onPressed: _jamMasuk != '-'
                                  ? null
                                  : () => _catatkanAbsen(true),
                              style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.primary),
                              child: Text(
                                _jamMasuk == '-'
                                    ? 'Absen Masuk'
                                    : 'Masuk: $_jamMasuk',
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FilledButton(
                              onPressed: (_jamMasuk == '-' || _jamPulang != '-')
                                  ? null
                                  : () => _catatkanAbsen(false),
                              style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.secondary),
                              child: Text(
                                _jamPulang == '-'
                                    ? 'Absen Pulang'
                                    : 'Pulang: $_jamPulang',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Riwayat Presensi Guru',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Divider(height: 20, color: AppColors.border),
                      for (final item in _riwayat)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['tanggal'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    item['jam'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.muted,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                item['status'] ?? '',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.success,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
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
