import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class SiswaAbsen {
  final String nis;
  final String nama;
  String status;

  SiswaAbsen({
    required this.nis,
    required this.nama,
    required this.status,
  });
}

class AbsensiSiswaPage extends StatefulWidget {
  const AbsensiSiswaPage({super.key});

  @override
  State<AbsensiSiswaPage> createState() => _AbsensiSiswaPageState();
}

class _AbsensiSiswaPageState extends State<AbsensiSiswaPage> {
  String _kelasDipilih = 'XI TKJ 2';
  final List<String> _daftarRombel = ['XI TKJ 2 (Wali Kelas)', 'XII TKJ 1'];

  final List<SiswaAbsen> _dataAbsen = [
    SiswaAbsen(nis: '240108', nama: 'Ahmad Zeki Saputra', status: 'Hadir'),
    SiswaAbsen(nis: '240109', nama: 'Dewi Lestari', status: 'Hadir'),
    SiswaAbsen(nis: '240110', nama: 'Muhammad Rizki', status: 'Sakit'),
    SiswaAbsen(nis: '240111', nama: 'Siti Nur Aisyah', status: 'Izin'),
    SiswaAbsen(nis: '240112', nama: 'Fajar Pratama', status: 'Alfa'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('1. Absensi Siswa Real-Time',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                const Text(
                    'Pilih rombel, catat kehadiran, dan lihat rekap harian/bulanan.',
                    style: TextStyle(fontSize: 13, color: AppColors.muted)),
                const SizedBox(height: 16),
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
                      DropdownButtonFormField<String>(
                        value: _kelasDipilih,
                        decoration: InputDecoration(
                          labelText: 'Rombongan Belajar (Rombel)',
                          filled: true,
                          fillColor: AppColors.background,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        items: _daftarRombel
                            .map((k) =>
                                DropdownMenuItem(value: k, child: Text(k)))
                            .toList(),
                        onChanged: (v) =>
                            setState(() => _kelasDipilih = v ?? _kelasDipilih),
                      ),
                      const Divider(height: 24),
                      const Text('Daftar Kehadiran Hari Ini',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 14)),
                      const SizedBox(height: 10),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _dataAbsen.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, i) {
                          final item = _dataAbsen[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item.nama,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w700)),
                                      Text('NIS: ${item.nis}',
                                          style: const TextStyle(
                                              fontSize: 11,
                                              color: AppColors.muted)),
                                    ],
                                  ),
                                ),
                                DropdownButton<String>(
                                  value: item.status,
                                  items: ['Hadir', 'Izin', 'Sakit', 'Alfa']
                                      .map((s) => DropdownMenuItem(
                                          value: s, child: Text(s)))
                                      .toList(),
                                  onChanged: (val) {
                                    if (val != null) {
                                      setState(() => item.status = val);
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                                    'Rekap absensi berhasil disimpan ke server.'))),
                        icon: const Icon(Icons.save_rounded, size: 16),
                        label: const Text('Simpan Rekap Absensi'),
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
