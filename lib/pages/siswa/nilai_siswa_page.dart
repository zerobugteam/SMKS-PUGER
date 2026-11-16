import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

typedef MapelItem = Map<String, dynamic>;

class NilaiSemesterPage extends StatefulWidget {
  const NilaiSemesterPage({super.key});

  @override
  State<NilaiSemesterPage> createState() => _NilaiSemesterPageState();
}

class _NilaiSemesterPageState extends State<NilaiSemesterPage> {
  String _selectedPeriode = 'Kelas XI - Semester 1 (Ganjil 2026/2027)';
  String _jenisEvaluasi = 'Rapor Akhir Semester (UAS)';

  final List<String> _opsiJenisEvaluasi = const [
    'Nilai Sisipan (UTS)',
    'Rapor Akhir Semester (UAS)',
  ];

  // Data Dummy Nilai: Hanya Semester 1 & Semester 2 per tingkat (Kelas X - XI)
  final Map<String, List<MapelItem>> _dataNilaiPerPeriode = {
    'Kelas XI - Semester 1 (Ganjil 2026/2027)': [
      {
        'kode': 'NAS-01',
        'mapel': 'Pendidikan Agama dan Budi Pekerti',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 88,
        'uts': 86,
        'uas': 90,
      },
      {
        'kode': 'NAS-02',
        'mapel': 'Pendidikan Pancasila dan Kewarganegaraan',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 85,
        'uts': 84,
        'uas': 87,
      },
      {
        'kode': 'NAS-03',
        'mapel': 'Bahasa Indonesia',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 86,
        'uts': 83,
        'uas': 88,
      },
      {
        'kode': 'NAS-04',
        'mapel': 'Matematika',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 82,
        'uts': 79,
        'uas': 83,
      },
      {
        'kode': 'NAS-05',
        'mapel': 'Bahasa Inggris',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 87,
        'uts': 85,
        'uas': 89,
      },
      {
        'kode': 'TKJ-01',
        'mapel': 'Teknologi Jaringan Berbasis Luas (WAN)',
        'kategori': 'Konsentrasi Keahlian',
        'kkm': 78,
        'tugas': 92,
        'uts': 90,
        'uas': 94,
      },
      {
        'kode': 'TKJ-02',
        'mapel': 'Administrasi Infrastruktur Jaringan (AIJ)',
        'kategori': 'Konsentrasi Keahlian',
        'kkm': 78,
        'tugas': 90,
        'uts': 88,
        'uas': 92,
      },
      {
        'kode': 'TKJ-03',
        'mapel': 'Administrasi Sistem Jaringan (ASJ)',
        'kategori': 'Konsentrasi Keahlian',
        'kkm': 78,
        'tugas': 89,
        'uts': 86,
        'uas': 90,
      },
      {
        'kode': 'TKJ-04',
        'mapel': 'Teknologi Layanan Jaringan (TLJ)',
        'kategori': 'Konsentrasi Keahlian',
        'kkm': 78,
        'tugas': 88,
        'uts': 87,
        'uas': 89,
      },
      {
        'kode': 'TKJ-05',
        'mapel': 'Produk Kreatif dan Kewirausahaan (PKK)',
        'kategori': 'Konsentrasi Keahlian',
        'kkm': 78,
        'tugas': 91,
        'uts': 89,
        'uas': 93,
      },
    ],
    'Kelas X - Semester 2 (Genap 2025/2026)': [
      {
        'kode': 'NAS-01',
        'mapel': 'Pendidikan Agama dan Budi Pekerti',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 87,
        'uts': 85,
        'uas': 88,
      },
      {
        'kode': 'NAS-02',
        'mapel': 'Pendidikan Pancasila dan Kewarganegaraan',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 84,
        'uts': 82,
        'uas': 85,
      },
      {
        'kode': 'NAS-03',
        'mapel': 'Bahasa Indonesia',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 85,
        'uts': 82,
        'uas': 86,
      },
      {
        'kode': 'NAS-04',
        'mapel': 'Matematika',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 80,
        'uts': 78,
        'uas': 81,
      },
      {
        'kode': 'NAS-05',
        'mapel': 'Bahasa Inggris',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 85,
        'uts': 83,
        'uas': 86,
      },
      {
        'kode': 'DAS-01',
        'mapel': 'Komputer dan Jaringan Dasar',
        'kategori': 'Dasar Program Keahlian',
        'kkm': 75,
        'tugas': 90,
        'uts': 88,
        'uas': 91,
      },
      {
        'kode': 'DAS-02',
        'mapel': 'Pemrograman Dasar',
        'kategori': 'Dasar Program Keahlian',
        'kkm': 75,
        'tugas': 87,
        'uts': 84,
        'uas': 88,
      },
      {
        'kode': 'DAS-03',
        'mapel': 'Desain Grafis Percetakan',
        'kategori': 'Dasar Program Keahlian',
        'kkm': 75,
        'tugas': 89,
        'uts': 86,
        'uas': 90,
      },
    ],
    'Kelas X - Semester 1 (Ganjil 2025/2026)': [
      {
        'kode': 'NAS-01',
        'mapel': 'Pendidikan Agama dan Budi Pekerti',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 85,
        'uts': 83,
        'uas': 86,
      },
      {
        'kode': 'NAS-02',
        'mapel': 'Pendidikan Pancasila dan Kewarganegaraan',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 82,
        'uts': 80,
        'uas': 84,
      },
      {
        'kode': 'NAS-03',
        'mapel': 'Bahasa Indonesia',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 83,
        'uts': 81,
        'uas': 84,
      },
      {
        'kode': 'NAS-04',
        'mapel': 'Matematika',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 78,
        'uts': 76,
        'uas': 79,
      },
      {
        'kode': 'NAS-05',
        'mapel': 'Bahasa Inggris',
        'kategori': 'Muatan Nasional',
        'kkm': 75,
        'tugas': 84,
        'uts': 81,
        'uas': 85,
      },
      {
        'kode': 'DAS-04',
        'mapel': 'Sistem Komputer',
        'kategori': 'Dasar Program Keahlian',
        'kkm': 75,
        'tugas': 86,
        'uts': 84,
        'uas': 88,
      },
      {
        'kode': 'DAS-05',
        'mapel': 'Simulasi dan Komunikasi Digital',
        'kategori': 'Dasar Program Keahlian',
        'kkm': 75,
        'tugas': 88,
        'uts': 85,
        'uas': 89,
      },
    ],
  };

  bool get _isModeSisipan => _jenisEvaluasi == 'Nilai Sisipan (UTS)';

  // Nilai Sisipan = 40% Tugas + 60% UTS | Nilai Rapor Akhir = 30% Tugas + 30% UTS + 40% UAS
  double _hitungNilai(MapelItem item) {
    final int tugas = item['tugas'] as int;
    final int uts = item['uts'] as int;
    if (_isModeSisipan) {
      return (tugas * 0.40) + (uts * 0.60);
    }
    final int uas = item['uas'] as int;
    return (tugas * 0.30) + (uts * 0.30) + (uas * 0.40);
  }

  String _getPredikat(double nilai) {
    if (nilai >= 90) return 'A';
    if (nilai >= 80) return 'B';
    if (nilai >= 75) return 'C';
    return 'D';
  }

  Color _getPredikatColor(String predikat) {
    switch (predikat) {
      case 'A':
        return AppColors.success;
      case 'B':
        return AppColors.primary;
      case 'C':
        return AppColors.warning;
      default:
        return AppColors.danger;
    }
  }

  String _getPeringkat() {
    if (_selectedPeriode.startsWith('Kelas XI - Semester 1')) return '3';
    if (_selectedPeriode.startsWith('Kelas X - Semester 2')) return '4';
    return '5';
  }

  String _getCatatanWaliKelas() {
    if (_isModeSisipan) {
      return 'Laporan Nilai Sisipan (UTS) merupakan evaluasi tengah semester sebelum Ujian Akhir Semester (UAS). '
          'Siswa yang sudah melampaui KKM agar mempertahankan capaian nilai hingga akhir semester.';
    }
    if (_selectedPeriode.startsWith('Kelas XI - Semester 1')) {
      return 'Prestasi akademik pada semester ganjil kelas XI sangat memuaskan, khususnya pada mata pelajaran '
          'Konsentrasi Keahlian TKJ. Persiapkan diri dengan baik menjelang pelaksanaan PKL.';
    }
    if (_selectedPeriode.startsWith('Kelas X - Semester 2')) {
      return 'Berdasarkan hasil evaluasi Semester 1 dan Semester 2, siswa dinyatakan NAIK KE KELAS XI '
          'Konsentrasi Keahlian Teknik Komputer dan Jaringan (TKJ).';
    }
    return 'Adaptasi pembelajaran di kelas X semester 1 berjalan dengan baik. Terus tingkatkan ketelitian '
        'pada mata pelajaran Matematika dan praktik dasar jaringan komputer.';
  }

  @override
  Widget build(BuildContext context) {
    final daftarNilai = _dataNilaiPerPeriode[_selectedPeriode] ?? [];
    final totalNilai = daftarNilai.fold<double>(
      0,
      (sum, item) => sum + _hitungNilai(item),
    );
    final rataRata =
        daftarNilai.isEmpty ? 0.0 : totalNilai / daftarNilai.length;
    final rataRataUts = daftarNilai.isEmpty
        ? 0.0
        : daftarNilai.fold<int>(0, (s, i) => s + (i['uts'] as int)) /
            daftarNilai.length;
    final rataRataUas = daftarNilai.isEmpty
        ? 0.0
        : daftarNilai.fold<int>(0, (s, i) => s + (i['uas'] as int)) /
            daftarNilai.length;
    final jumlahTuntas = daftarNilai
        .where((item) => _hitungNilai(item) >= (item['kkm'] as int))
        .length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1080),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 1. Header & Filter Kelas/Semester (1-2) + Jenis Nilai (Sisipan UTS / Rapor UAS)
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 820;
                  final headerTitle = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Laporan Nilai Sisipan (UTS) & Rapor Semester',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppColors.text,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Ahmad Zeki Saputra (NIS: 240108) • Teknik Komputer dan Jaringan',
                        style: TextStyle(fontSize: 13, color: AppColors.muted),
                      ),
                    ],
                  );

                  final filterControls = Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      // Dropdown Kelas & Semester (1 - 2)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedPeriode,
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.primary,
                            ),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.text,
                            ),
                            items: _dataNilaiPerPeriode.keys.map((periode) {
                              return DropdownMenuItem(
                                value: periode,
                                child: Text(periode),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _selectedPeriode = value);
                              }
                            },
                          ),
                        ),
                      ),

                      // Dropdown Jenis Nilai (Sisipan UTS / Rapor UAS)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: _isModeSisipan
                              ? const Color(0xFFFFFBEB)
                              : AppColors.surface,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: _isModeSisipan
                                ? AppColors.warning
                                : AppColors.primary,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _jenisEvaluasi,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: _isModeSisipan
                                  ? AppColors.warning
                                  : AppColors.primary,
                            ),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: _isModeSisipan
                                  ? const Color(0xFFB45309)
                                  : AppColors.primaryDark,
                            ),
                            items: _opsiJenisEvaluasi.map((jenis) {
                              return DropdownMenuItem(
                                value: jenis,
                                child: Text(jenis),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _jenisEvaluasi = value);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  );

                  if (isWide) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: headerTitle),
                        const SizedBox(width: 16),
                        filterControls,
                      ],
                    );
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      headerTitle,
                      const SizedBox(height: 12),
                      filterControls,
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // 2. Kartu Ringkasan Statistik Nilai
              LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth >= 880
                      ? 4
                      : constraints.maxWidth >= 500
                          ? 2
                          : 1;
                  return GridView.count(
                    crossAxisCount: columns,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: columns == 1 ? 3.2 : 2.05,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildStatCard(
                        title: _isModeSisipan
                            ? 'Rata-Rata Nilai Sisipan'
                            : 'Rata-Rata Nilai Rapor',
                        value: rataRata.toStringAsFixed(2),
                        subtitle:
                            'Predikat ${_getPredikat(rataRata)} (Kompeten)',
                        icon: Icons.analytics_outlined,
                        accentColor: AppColors.primary,
                      ),
                      _buildStatCard(
                        title: _isModeSisipan
                            ? 'Rata-Rata Ujian UTS'
                            : 'Rata-Rata UTS / UAS',
                        value: _isModeSisipan
                            ? rataRataUts.toStringAsFixed(1)
                            : '${rataRataUts.toStringAsFixed(1)} / ${rataRataUas.toStringAsFixed(1)}',
                        subtitle: _isModeSisipan
                            ? 'Nilai Murni Tengah Semester'
                            : 'Tengah & Akhir Semester',
                        icon: Icons.assignment_turned_in_outlined,
                        accentColor: AppColors.secondary,
                      ),
                      _buildStatCard(
                        title: 'Ketuntasan Mapel',
                        value: '$jumlahTuntas / ${daftarNilai.length}',
                        subtitle: '100% Mencapai KKM',
                        icon: Icons.check_circle_outline,
                        accentColor: AppColors.success,
                      ),
                      _buildStatCard(
                        title: 'Peringkat Kelas',
                        value: _getPeringkat(),
                        subtitle: 'Dari 34 Siswa',
                        icon: Icons.emoji_events_outlined,
                        accentColor: AppColors.warning,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),

              // 3. Tabel Daftar Nilai Mata Pelajaran
              Material(
                color: AppColors.surface,
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 20,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF8F9FA),
                        border: Border(
                          bottom: BorderSide(color: AppColors.border),
                        ),
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          Text(
                            '$_jenisEvaluasi • $_selectedPeriode',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: (_isModeSisipan
                                      ? AppColors.warning
                                      : AppColors.primary)
                                  .withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _isModeSisipan
                                  ? 'Bobot Sisipan: 40% Tugas • 60% UTS'
                                  : 'Bobot Rapor: 30% Tugas • 30% UTS • 40% UAS',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w600,
                                color: _isModeSisipan
                                    ? const Color(0xFFB45309)
                                    : AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(minWidth: 920),
                        child: DataTable(
                          headingRowColor: WidgetStateProperty.all(
                            AppColors.background,
                          ),
                          dataRowMinHeight: 54,
                          dataRowMaxHeight: 62,
                          columnSpacing: 22,
                          horizontalMargin: 20,
                          columns: [
                            const DataColumn(
                              label: Text(
                                'Kode',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                            const DataColumn(
                              label: Text(
                                'Mata Pelajaran',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                            const DataColumn(
                              numeric: true,
                              label: Text(
                                'KKM',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                            const DataColumn(
                              numeric: true,
                              label: Text(
                                'Tugas',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                            const DataColumn(
                              numeric: true,
                              label: Text(
                                'UTS',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryDark,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                            if (!_isModeSisipan)
                              const DataColumn(
                                numeric: true,
                                label: Text(
                                  'UAS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryDark,
                                    fontSize: 12.5,
                                  ),
                                ),
                              ),
                            DataColumn(
                              numeric: true,
                              label: Text(
                                _isModeSisipan
                                    ? 'Nilai Sisipan'
                                    : 'Nilai Akhir',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                            const DataColumn(
                              label: Text(
                                'Predikat',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                            const DataColumn(
                              label: Text(
                                'Status',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.text,
                                  fontSize: 12.5,
                                ),
                              ),
                            ),
                          ],
                          rows: daftarNilai.map((item) {
                            final nilaiAkhir = _hitungNilai(item);
                            final predikat = _getPredikat(nilaiAkhir);
                            final int kkm = item['kkm'] as int;
                            final isTuntas = nilaiAkhir >= kkm;
                            final badgeColor = _getPredikatColor(predikat);

                            return DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    item['kode'] as String,
                                    style: const TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.muted,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item['mapel'] as String,
                                        style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.text,
                                        ),
                                      ),
                                      Text(
                                        item['kategori'] as String,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          color: AppColors.muted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '$kkm',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.muted,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '${item['tugas']}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.text,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    '${item['uts']}',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.text,
                                    ),
                                  ),
                                ),
                                if (!_isModeSisipan)
                                  DataCell(
                                    Text(
                                      '${item['uas']}',
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.text,
                                      ),
                                    ),
                                  ),
                                DataCell(
                                  Text(
                                    nilaiAkhir.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 13.5,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.primaryDark,
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    width: 28,
                                    height: 28,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: badgeColor.withValues(alpha: 0.14),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      predikat,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.5,
                                        color: badgeColor,
                                      ),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: (isTuntas
                                              ? AppColors.success
                                              : AppColors.danger)
                                          .withValues(alpha: 0.12),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      isTuntas ? 'Tuntas' : 'Belum Tuntas',
                                      style: TextStyle(
                                        fontSize: 11.5,
                                        fontWeight: FontWeight.w700,
                                        color: isTuntas
                                            ? AppColors.success
                                            : AppColors.danger,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // 4. Catatan Wali Kelas Dinamis
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.format_quote_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Catatan Wali Kelas (Yogiswara, S.T., Gr.)',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                              color: AppColors.text,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getCatatanWaliKelas(),
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: AppColors.muted,
                              height: 1.4,
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
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accentColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11, color: AppColors.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
