import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class SiswaNilaiItem {
  final String nis;
  final String nama;
  final TextEditingController tugasController;
  final TextEditingController utsController;
  final TextEditingController uasController;
  final TextEditingController praktikController;

  SiswaNilaiItem({
    required this.nis,
    required this.nama,
    String tugas = '',
    String uts = '',
    String uas = '',
    String praktik = '',
  })  : tugasController = TextEditingController(text: tugas),
        utsController = TextEditingController(text: uts),
        uasController = TextEditingController(text: uas),
        praktikController = TextEditingController(text: praktik);

  void dispose() {
    tugasController.dispose();
    utsController.dispose();
    uasController.dispose();
    praktikController.dispose();
  }

  double get nilaiAkhir {
    final t = double.tryParse(tugasController.text) ?? 0;
    final u = double.tryParse(utsController.text) ?? 0;
    final us = double.tryParse(uasController.text) ?? 0;
    final p = double.tryParse(praktikController.text) ?? 0;
    return (t * 0.20) + (u * 0.25) + (us * 0.30) + (p * 0.25);
  }

  String get predikat {
    final na = nilaiAkhir;
    if (na >= 85) return 'A';
    if (na >= 75) return 'B';
    if (na >= 65) return 'C';
    return 'D';
  }
}

class InputNilaiPage extends StatefulWidget {
  const InputNilaiPage({super.key});

  @override
  State<InputNilaiPage> createState() => _InputNilaiPageState();
}

class _InputNilaiPageState extends State<InputNilaiPage> {
  String _selectedKelas = 'XI TKJ 2';
  String _selectedMapel = 'Teknologi Jaringan Berbasis Luas (WAN)';

  final List<String> _daftarKelas = const [
    'XI TKJ 2',
    'XII TKJ 1',
    'X TKJ 1',
  ];

  final List<String> _daftarMapel = const [
    'Teknologi Jaringan Berbasis Luas (WAN)',
    'Administrasi Infrastruktur Jaringan (AIJ)',
    'Teknologi Layanan Jaringan (TLJ)',
  ];

  late final List<SiswaNilaiItem> _daftarSiswa;

  @override
  void initState() {
    super.initState();
    _daftarSiswa = [
      SiswaNilaiItem(
          nis: '240108',
          nama: 'Ahmad Zeki Saputra',
          tugas: '85',
          uts: '80',
          uas: '88',
          praktik: '90'),
      SiswaNilaiItem(
          nis: '240109',
          nama: 'Dewi Lestari',
          tugas: '90',
          uts: '85',
          uas: '92',
          praktik: '88'),
      SiswaNilaiItem(
          nis: '240110',
          nama: 'Muhammad Rizki',
          tugas: '75',
          uts: '70',
          uas: '78',
          praktik: '80'),
      SiswaNilaiItem(
          nis: '240111',
          nama: 'Siti Nur Aisyah',
          tugas: '88',
          uts: '85',
          uas: '85',
          praktik: '92'),
      SiswaNilaiItem(
          nis: '240112',
          nama: 'Fajar Pratama',
          tugas: '80',
          uts: '78',
          uas: '82',
          praktik: '85'),
    ];
  }

  @override
  void dispose() {
    for (var siswa in _daftarSiswa) {
      siswa.dispose();
    }
    super.dispose();
  }

  void _simpanNilai() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Nilai berhasil disimpan dan disinkronkan ke server.'),
        backgroundColor: AppColors.success,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Pengelolaan & Input Nilai Siswa',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Yogiswara, S.T., Gr. • Semester Ganjil 2026/2027',
                  style: TextStyle(fontSize: 13, color: AppColors.muted),
                ),
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
                      const Text(
                        'Pilih Kelas & Mata Pelajaran',
                        style: TextStyle(
                            fontSize: 13.5, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              value: _selectedKelas,
                              decoration: InputDecoration(
                                labelText: 'Kelas',
                                filled: true,
                                fillColor: AppColors.background,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              items: _daftarKelas.map((kelas) {
                                return DropdownMenuItem(
                                    value: kelas, child: Text(kelas));
                              }).toList(),
                              onChanged: (val) {
                                if (val != null)
                                  setState(() => _selectedKelas = val);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              value: _selectedMapel,
                              decoration: InputDecoration(
                                labelText: 'Mata Pelajaran',
                                filled: true,
                                fillColor: AppColors.background,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              items: _daftarMapel.map((mapel) {
                                return DropdownMenuItem(
                                    value: mapel,
                                    child: Text(mapel,
                                        overflow: TextOverflow.ellipsis));
                              }).toList(),
                              onChanged: (val) {
                                if (val != null)
                                  setState(() => _selectedMapel = val);
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        color: const Color(0xFFF8F9FA),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Daftar Nilai • $_selectedKelas',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDark,
                              ),
                            ),
                            FilledButton.icon(
                              onPressed: _simpanNilai,
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 8),
                              ),
                              icon: const Icon(Icons.save_rounded, size: 16),
                              label: const Text('Simpan'),
                            ),
                          ],
                        ),
                      ),
                      const Divider(height: 1, color: AppColors.border),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _daftarSiswa.length,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 1, color: AppColors.border),
                        itemBuilder: (context, index) {
                          final siswa = _daftarSiswa[index];
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${index + 1}. ${siswa.nama}',
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text('NIS: ${siswa.nis}',
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.muted)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                // Baris 1 Input Nilai (Tugas & UTS)
                                Row(
                                  children: [
                                    Expanded(
                                        child: _buildInputBox('Tugas (20%)',
                                            siswa.tugasController)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                        child: _buildInputBox(
                                            'UTS (25%)', siswa.utsController)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                        child: _buildInputBox(
                                            'UAS (30%)', siswa.uasController)),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                // Baris 2 Input Nilai (Praktik & Nilai Akhir)
                                Row(
                                  children: [
                                    Expanded(
                                        child: _buildInputBox('Praktik (25%)',
                                            siswa.praktikController)),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      flex: 2,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.background,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border: Border.all(
                                              color: AppColors.border),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text('Nilai Akhir: ',
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    color: AppColors.muted)),
                                            ListenableBuilder(
                                              listenable: Listenable.merge([
                                                siswa.tugasController,
                                                siswa.utsController,
                                                siswa.uasController,
                                                siswa.praktikController,
                                              ]),
                                              builder: (context, _) {
                                                return Text(
                                                  siswa.nilaiAkhir
                                                      .toStringAsFixed(1),
                                                  style: const TextStyle(
                                                    fontSize: 13.5,
                                                    fontWeight: FontWeight.w800,
                                                    color: AppColors.primary,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
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

  Widget _buildInputBox(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(fontSize: 10.5),
        isDense: true,
        filled: true,
        fillColor: AppColors.background,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onChanged: (_) => setState(() {}),
    );
  }
}
