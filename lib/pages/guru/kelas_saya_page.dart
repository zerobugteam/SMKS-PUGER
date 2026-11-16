import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class MataPelajaranNilai {
  final String namaMapel;
  double tugas;
  double uts;
  double uas;
  double praktik;

  MataPelajaranNilai({
    required this.namaMapel,
    required this.tugas,
    required this.uts,
    required this.uas,
    required this.praktik,
  });

  double get nilaiAkhir =>
      (tugas * 0.2) + (uts * 0.25) + (uas * 0.35) + (praktik * 0.2);
  String get status => nilaiAkhir >= 75 ? 'Tuntas' : 'Remidi';
}

class SiswaPerwalian {
  final String nis;
  final String nama;
  final String statusKeaktifan;
  String presensiStatus; // Hadir, Izin, Sakit, Alfa
  final List<MataPelajaranNilai> daftarNilaiMapel;

  SiswaPerwalian({
    required this.nis,
    required this.nama,
    required this.statusKeaktifan,
    required this.presensiStatus,
    required this.daftarNilaiMapel,
  });

  double get rataRataAkhir {
    if (daftarNilaiMapel.isEmpty) return 0.0;
    double total = daftarNilaiMapel.fold(0.0, (sum, m) => sum + m.nilaiAkhir);
    return total / daftarNilaiMapel.length;
  }
}

class KelasSayaPage extends StatefulWidget {
  const KelasSayaPage({super.key});

  @override
  State<KelasSayaPage> createState() => _KelasSayaPageState();
}

class _KelasSayaPageState extends State<KelasSayaPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<SiswaPerwalian> _daftarSiswa = [
    SiswaPerwalian(
      nis: '240108',
      nama: 'Ahmad Zeki Saputra',
      statusKeaktifan: 'Aktif',
      presensiStatus: 'Hadir',
      daftarNilaiMapel: [
        MataPelajaranNilai(
            namaMapel: 'Teknologi Jaringan Berbasis Luas (WAN)',
            tugas: 85,
            uts: 80,
            uas: 88,
            praktik: 86),
        MataPelajaranNilai(
            namaMapel: 'Teknologi Layanan Jaringan (TLJ)',
            tugas: 88,
            uts: 85,
            uas: 90,
            praktik: 87),
      ],
    ),
    SiswaPerwalian(
      nis: '240109',
      nama: 'Dewi Lestari',
      statusKeaktifan: 'Aktif',
      presensiStatus: 'Hadir',
      daftarNilaiMapel: [
        MataPelajaranNilai(
            namaMapel: 'Teknologi Jaringan Berbasis Luas (WAN)',
            tugas: 92,
            uts: 90,
            uas: 95,
            praktik: 92),
        MataPelajaranNilai(
            namaMapel: 'Teknologi Layanan Jaringan (TLJ)',
            tugas: 90,
            uts: 88,
            uas: 92,
            praktik: 89),
      ],
    ),
  ];

  final List<String> _jadwalPersemester = [
    'Semester Ganjil 2026/2027 - Bulan 1: Pengenalan Kurikulum & Dasar Jaringan',
    'Semester Ganjil 2026/2027 - Bulan 2: Praktikum Routing & Switch (UTS)',
    'Semester Ganjil 2026/2027 - Bulan 3: Proyek Integrasi & Evaluasi (UAS)',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _pesan(String teks, [Color warna = AppColors.success]) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(teks),
          backgroundColor: warna,
          duration: const Duration(seconds: 2)),
    );
  }

  void _bukaFormEditNilai(BuildContext dialogContext, SiswaPerwalian siswa) {
    showDialog(
      context: dialogContext,
      builder: (ctx) {
        return AlertDialog(
          title: Text('Edit Nilai Rinci: ${siswa.nama}'),
          content: SizedBox(
            width: 500,
            height: 380,
            child: ListView.builder(
              itemCount: siswa.daftarNilaiMapel.length,
              itemBuilder: (context, i) {
                final mapel = siswa.daftarNilaiMapel[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: ExpansionTile(
                    title: Text(mapel.namaMapel,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        'Nilai Akhir: ${mapel.nilaiAkhir.toStringAsFixed(1)}',
                        style: const TextStyle(
                            fontSize: 11, color: AppColors.primary)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                        initialValue: mapel.tugas.toString(),
                                        decoration: const InputDecoration(
                                            labelText: 'Tugas', isDense: true),
                                        keyboardType: TextInputType.number,
                                        onChanged: (v) => mapel.tugas =
                                            double.tryParse(v) ?? mapel.tugas)),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: TextFormField(
                                        initialValue: mapel.uts.toString(),
                                        decoration: const InputDecoration(
                                            labelText: 'UTS', isDense: true),
                                        keyboardType: TextInputType.number,
                                        onChanged: (v) => mapel.uts =
                                            double.tryParse(v) ?? mapel.uts)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                    child: TextFormField(
                                        initialValue: mapel.uas.toString(),
                                        decoration: const InputDecoration(
                                            labelText: 'UAS', isDense: true),
                                        keyboardType: TextInputType.number,
                                        onChanged: (v) => mapel.uas =
                                            double.tryParse(v) ?? mapel.uas)),
                                const SizedBox(width: 8),
                                Expanded(
                                    child: TextFormField(
                                        initialValue: mapel.praktik.toString(),
                                        decoration: const InputDecoration(
                                            labelText: 'Praktik',
                                            isDense: true),
                                        keyboardType: TextInputType.number,
                                        onChanged: (v) => mapel.praktik =
                                            double.tryParse(v) ??
                                                mapel.praktik)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Batal')),
            FilledButton(
              onPressed: () {
                setState(() {});
                Navigator.pop(ctx);
                Navigator.pop(dialogContext);
                _pesan('Nilai ${siswa.nama} berhasil diperbarui.');
              },
              child: const Text('Simpan Perubahan'),
            ),
          ],
        );
      },
    );
  }

  void _tampilkanDetailRapor(BuildContext context, SiswaPerwalian siswa) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Rekap Rinci Nilai (Tugas, UTS, UAS, Praktik)',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                  IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.pop(ctx)),
                ],
              ),
              const Divider(height: 10),
              Text(siswa.nama,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary)),
              Text(
                  'NIS: ${siswa.nis} • Rata-rata Akhir: ${siswa.rataRataAkhir.toStringAsFixed(1)}',
                  style: const TextStyle(fontSize: 12, color: AppColors.muted)),
            ],
          ),
          content: SizedBox(
            width: 580,
            height: 380,
            child: ListView.separated(
              itemCount: siswa.daftarNilaiMapel.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 12, color: AppColors.border),
              itemBuilder: (context, idx) {
                final mapel = siswa.daftarNilaiMapel[idx];
                final isTuntas = mapel.nilaiAkhir >= 75;
                return Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.border)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mapel.namaMapel,
                                style: const TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w700),
                                overflow: TextOverflow.ellipsis),
                            Text(
                                'Tugas: ${mapel.tugas.toInt()} | UTS: ${mapel.uts.toInt()} | UAS: ${mapel.uas.toInt()} | Praktik: ${mapel.praktik.toInt()}',
                                style: const TextStyle(
                                    fontSize: 11, color: AppColors.muted)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('NA: ${mapel.nilaiAkhir.toStringAsFixed(1)}',
                              style: const TextStyle(
                                  fontSize: 12.5,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.primary)),
                          Text(mapel.status,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  color: isTuntas
                                      ? AppColors.success
                                      : AppColors.danger)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          actions: [
            OutlinedButton.icon(
              onPressed: () => _bukaFormEditNilai(ctx, siswa),
              icon: const Icon(Icons.edit_rounded, size: 16),
              label: const Text('Edit Nilai'),
            ),
            FilledButton.icon(
              onPressed: () => _pesan('Mencetak Rapor PDF ${siswa.nama}...'),
              icon: const Icon(Icons.print_rounded, size: 16),
              label: const Text('Cetak Rapor'),
            ),
          ],
        );
      },
    );
  }

  void _dialogBuatJadwalSemester(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Buat Jadwal Persemester'),
          content: const TextField(
              decoration: InputDecoration(
                  labelText: 'Keterangan Agenda Semester',
                  filled: true,
                  fillColor: AppColors.background)),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Batal')),
            FilledButton(
              onPressed: () {
                Navigator.pop(ctx);
                _pesan('Jadwal persemester berhasil ditambahkan.');
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
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
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0F294A), Color(0xFF1E3A8A)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Wali Kelas: XI TKJ 2',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white)),
                            SizedBox(height: 4),
                            Text(
                                'Rekap Nilai (Tugas, UTS, UAS, Praktik), Absensi, & Jadwal Persemester',
                                style: TextStyle(
                                    fontSize: 12.5, color: Color(0xFF93C5FD))),
                          ],
                        ),
                      ),
                      FilledButton.icon(
                        onPressed: () => _pesan('Mengunduh Rekap Kelas...'),
                        style: FilledButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: AppColors.primary),
                        icon: const Icon(Icons.download_rounded, size: 16),
                        label: const Text('Rekap'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    labelColor: AppColors.primary,
                    unselectedLabelColor: AppColors.muted,
                    indicatorColor: AppColors.primary,
                    isScrollable: true,
                    tabs: const [
                      Tab(text: 'Daftar Siswa'),
                      Tab(text: 'Rekap Nilai & Pengolahan'),
                      Tab(text: 'Rekap Kehadiran'),
                      Tab(text: 'Jadwal Persemester'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 520,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // TAB 1: DAFTAR SISWA
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border)),
                        child: ListView.separated(
                          itemCount: _daftarSiswa.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, i) {
                            final s = _daftarSiswa[i];
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(s.nama,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                fontSize: 13.5)),
                                        Text(
                                            'NIS: ${s.nis} • Status: ${s.statusKeaktifan}',
                                            style: const TextStyle(
                                                fontSize: 11,
                                                color: AppColors.muted)),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: AppColors.primary
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Text(s.statusKeaktifan,
                                        style: const TextStyle(
                                            fontSize: 10.5,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primary)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      // TAB 2: REKAP NILAI (TUGAS, UTS, UAS, PRAKTIK) & EDIT
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                                'Ketuk Nama Siswa untuk Rekap Nilai Rinci (Tugas, UTS, UAS, Praktik) & Edit',
                                style: TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.muted)),
                            const Divider(height: 16),
                            Expanded(
                              child: ListView.separated(
                                itemCount: _daftarSiswa.length,
                                separatorBuilder: (_, __) =>
                                    const Divider(height: 1),
                                itemBuilder: (context, i) {
                                  final s = _daftarSiswa[i];
                                  return InkWell(
                                    onTap: () =>
                                        _tampilkanDetailRapor(context, s),
                                    borderRadius: BorderRadius.circular(8),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(s.nama,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 13,
                                                        color:
                                                            AppColors.primary)),
                                                Text(
                                                    'Rata-rata Akhir: ${s.rataRataAkhir.toStringAsFixed(1)}',
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        color:
                                                            AppColors.muted)),
                                              ],
                                            ),
                                          ),
                                          const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 14,
                                              color: AppColors.muted),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // TAB 3: REKAP KEHADIRAN KELAS
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Rekap Kehadiran Siswa Perwalian',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.muted)),
                            const Divider(height: 16),
                            Expanded(
                              child: ListView.separated(
                                itemCount: _daftarSiswa.length,
                                separatorBuilder: (_, __) =>
                                    const Divider(height: 1),
                                itemBuilder: (context, i) {
                                  final s = _daftarSiswa[i];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text(s.nama,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 13))),
                                        DropdownButton<String>(
                                          value: s.presensiStatus,
                                          items: [
                                            'Hadir',
                                            'Izin',
                                            'Sakit',
                                            'Alfa'
                                          ]
                                              .map((st) => DropdownMenuItem(
                                                  value: st, child: Text(st)))
                                              .toList(),
                                          onChanged: (val) {
                                            if (val != null)
                                              setState(
                                                  () => s.presensiStatus = val);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      // TAB 4: JADWAL PERSEMESTER
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                    'Pembuatan Jadwal / Kalender Persemester',
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700)),
                                OutlinedButton.icon(
                                  onPressed: () =>
                                      _dialogBuatJadwalSemester(context),
                                  icon: const Icon(Icons.add_rounded, size: 16),
                                  label: const Text('Buat Jadwal'),
                                ),
                              ],
                            ),
                            const Divider(height: 16),
                            Expanded(
                              child: ListView.separated(
                                itemCount: _jadwalPersemester.length,
                                separatorBuilder: (_, __) =>
                                    const Divider(height: 1),
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text('• ${_jadwalPersemester[i]}',
                                        style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600)),
                                  );
                                },
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
