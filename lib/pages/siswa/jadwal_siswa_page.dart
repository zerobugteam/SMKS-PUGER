import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart' as pw_pdf;
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../core/app_colors.dart';

typedef JadwalItem = Map<String, String>;

class JadwalPelajaranPage extends StatefulWidget {
  const JadwalPelajaranPage({super.key});

  @override
  State<JadwalPelajaranPage> createState() => _JadwalPelajaranPageState();
}

class _JadwalPelajaranPageState extends State<JadwalPelajaranPage> {
  String _selectedHari = 'Senin';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _daftarHari = const [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Semua Hari',
  ];

  // Data Jadwal Pelajaran - Kelas XI TKJ 2 SMKS Puger
  final Map<String, List<JadwalItem>> _jadwalPerHari = const {
    'Senin': [
      {
        'waktu': '07.00 - 07.45',
        'mapel': 'Upacara Bendera',
        'guru': 'Wali Kelas & Pembina',
        'ruang': 'Lapangan Utama',
      },
      {
        'waktu': '07.45 - 09.45',
        'mapel': 'Teknologi Jaringan Berbasis Luas (WAN)',
        'guru': 'Yogiswara, S.T., Gr.',
        'ruang': 'Lab. Jaringan TKJ 1',
      },
      {
        'waktu': '10.15 - 12.15',
        'mapel': 'Matematika',
        'guru': 'Dra. Siti Aminah',
        'ruang': 'Ruang XI-04',
      },
      {
        'waktu': '13.00 - 14.30',
        'mapel': 'Bahasa Indonesia',
        'guru': 'Rina Wahyuni, S.Pd.',
        'ruang': 'Ruang XI-04',
      },
    ],
    'Selasa': [
      {
        'waktu': '07.00 - 09.40',
        'mapel': 'Administrasi Infrastruktur Jaringan (AIJ)',
        'guru': 'Lalitya Nindita Sahenda, S.Pd.',
        'ruang': 'Lab. Cisco & Routing',
      },
      {
        'waktu': '10.10 - 11.30',
        'mapel': 'Pendidikan Agama dan Budi Pekerti',
        'guru': 'H. Ahmad Fauzi, S.Ag.',
        'ruang': 'Ruang XI-04',
      },
      {
        'waktu': '12.30 - 14.30',
        'mapel': 'Bahasa Inggris',
        'guru': 'Dian Kusumawardani, S.Pd.',
        'ruang': 'Lab. Bahasa',
      },
    ],
    'Rabu': [
      {
        'waktu': '07.00 - 09.40',
        'mapel': 'Administrasi Sistem Jaringan (ASJ)',
        'guru': 'Budi Santoso, S.Kom.',
        'ruang': 'Lab. Server TKJ 2',
      },
      {
        'waktu': '10.10 - 11.30',
        'mapel': 'Pendidikan Pancasila (PPKn)',
        'guru': 'Drs. Bambang Sutrisno',
        'ruang': 'Ruang XI-04',
      },
      {
        'waktu': '12.30 - 14.30',
        'mapel': 'Teknologi Layanan Jaringan (TLJ)',
        'guru': 'Yogiswara, S.T., Gr.',
        'ruang': 'Lab. VoIP & Fiber Optik',
      },
    ],
    'Kamis': [
      {
        'waktu': '07.00 - 09.00',
        'mapel': 'Pendidikan Jasmani & Olahraga (PJOK)',
        'guru': 'Eko Prasetyo, S.Pd.',
        'ruang': 'Lapangan Olahraga',
      },
      {
        'waktu': '09.30 - 12.10',
        'mapel': 'Produk Kreatif dan Kewirausahaan (PKK)',
        'guru': 'Lalitya Nindita Sahenda, S.Pd.',
        'ruang': 'Bengkel Kerja TKJ',
      },
      {
        'waktu': '13.00 - 14.30',
        'mapel': 'Bimbingan Konseling & Persiapan PKL',
        'guru': 'Nurul Hidayati, S.Psi.',
        'ruang': 'Ruang XI-04',
      },
    ],
    'Jumat': [
      {
        'waktu': '07.00 - 07.30',
        'mapel': 'Jumat Bersih / Istighosah',
        'guru': 'Tim Kesiswaan',
        'ruang': 'Halaman Sekolah',
      },
      {
        'waktu': '07.30 - 09.30',
        'mapel': 'Praktik Mikrotik & Fiber Optik',
        'guru': 'Budi Santoso, S.Kom.',
        'ruang': 'Lab. Jaringan TKJ 1',
      },
      {
        'waktu': '10.00 - 11.15',
        'mapel': 'Bahasa Jawa',
        'guru': 'Endang Sulistyowati, S.Pd.',
        'ruang': 'Ruang XI-04',
      },
    ],
  };

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Fungsi untuk Menghasilkan dan Mencetak Dokumen PDF Profesional
  Future<void> _cetakPdf() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: pw_pdf.PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return [
            // Kop Surat / Header PDF
            pw.Header(
              level: 0,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                children: [
                  pw.Text(
                    'SMKS PUGER JEMBER',
                    style: pw.TextStyle(
                      fontSize: 18,
                      fontWeight: pw.FontWeight.bold,
                      color: pw_pdf.PdfColors.blue900,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'JADWAL PELAJARAN KELAS XI TKJ 2 • SEMESTER GANJIL 2026/2027',
                    style: pw.TextStyle(
                      fontSize: 12,
                      fontWeight: pw.FontWeight.bold,
                      color: pw_pdf.PdfColors.grey700,
                    ),
                  ),
                  pw.SizedBox(height: 4),
                  pw.Text(
                    'Wali Kelas: Yogiswara, S.T., Gr.',
                    style: const pw.TextStyle(
                      fontSize: 10,
                      color: pw_pdf.PdfColors.grey600,
                    ),
                  ),
                  pw.Divider(thickness: 1.5, color: pw_pdf.PdfColors.blue900),
                ],
              ),
            ),
            pw.SizedBox(height: 10),

            // Konten Per Hari
            ..._jadwalPerHari.entries.map((entry) {
              final hari = entry.key;
              final items = entry.value;

              return pw.Container(
                margin: const pw.EdgeInsets.only(bottom: 16),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      padding: const pw.EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      color: pw_pdf.PdfColors.grey200,
                      width: double.infinity,
                      child: pw.Text(
                        'HARI ${hari.toUpperCase()}',
                        style: pw.TextStyle(
                          fontSize: 11,
                          fontWeight: pw.FontWeight.bold,
                          color: pw_pdf.PdfColors.blue800,
                        ),
                      ),
                    ),
                    pw.SizedBox(height: 6),
                    pw.Table.fromTextArray(
                      context: context,
                      headerStyle: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 10,
                        color: pw_pdf.PdfColors.white,
                      ),
                      headerDecoration: const pw.BoxDecoration(
                        color: pw_pdf.PdfColors.blue800,
                      ),
                      cellStyle: const pw.TextStyle(fontSize: 10),
                      cellPadding: const pw.EdgeInsets.all(6),
                      headers: [
                        'Waktu',
                        'Mata Pelajaran',
                        'Guru Pengampu',
                        'Ruang'
                      ],
                      data: items.map((sesi) {
                        return [
                          sesi['waktu'] ?? '',
                          sesi['mapel'] ?? '',
                          sesi['guru'] ?? '',
                          sesi['ruang'] ?? '',
                        ];
                      }).toList(),
                    ),
                  ],
                ),
              );
            }),

            pw.SizedBox(height: 20),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Catatan: Istirahat I (09.40 - 10.10) | Ishoma Dzuhur (12.15 - 13.00)',
                  style: const pw.TextStyle(
                    fontSize: 9,
                    color: pw_pdf.PdfColors.grey600,
                  ),
                ),
                pw.Text(
                  'Dicetak otomatis oleh Sistem Akademik SMKS Puger',
                  style: const pw.TextStyle(
                    fontSize: 8,
                    color: pw_pdf.PdfColors.grey500,
                  ),
                ),
              ],
            ),
          ];
        },
      ),
    );

    // Tampilkan pratinjau cetak / simpan PDF
    await Printing.layoutPdf(
      onLayout: (pw_pdf.PdfPageFormat format) async => pdf.save(),
      name: 'Jadwal_XI_TKJ_2_SMKS_Puger.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    final hariListToShow = _selectedHari == 'Semua Hari'
        ? _jadwalPerHari.keys.toList()
        : [_selectedHari];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 920),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Header & Tombol Cetak PDF
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jadwal Pelajaran',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: AppColors.text,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Kelas XI TKJ 2 • Wali Kelas: Yogiswara, S.T., Gr.',
                          style:
                              TextStyle(fontSize: 13, color: AppColors.muted),
                        ),
                      ],
                    ),
                    FilledButton.icon(
                      onPressed: _cetakPdf,
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.print_rounded, size: 18),
                      label: const Text('Cetak / Simpan PDF'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 2. Bar Pencarian (Search Input)
                TextField(
                  controller: _searchController,
                  onChanged: (val) => setState(() => _searchQuery = val),
                  decoration: InputDecoration(
                    hintText: 'Cari mata pelajaran atau nama guru pengampu...',
                    prefixIcon:
                        const Icon(Icons.search, color: AppColors.muted),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // 3. Pilihan Hari (Choice Chips)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _daftarHari.map((hari) {
                      final isSelected = _selectedHari == hari;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          selected: isSelected,
                          showCheckmark: false,
                          backgroundColor: AppColors.surface,
                          selectedColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          side: BorderSide(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                          ),
                          label: Text(
                            hari,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: isSelected ? Colors.white : AppColors.text,
                            ),
                          ),
                          onSelected: (_) =>
                              setState(() => _selectedHari = hari),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 16),

                // 4. Daftar Kartu Jadwal per Hari
                ...hariListToShow.map((hari) {
                  final items = (_jadwalPerHari[hari] ?? []).where((sesi) {
                    if (_searchQuery.isEmpty) return true;
                    final query = _searchQuery.toLowerCase();
                    final mapel = (sesi['mapel'] ?? '').toLowerCase();
                    final guru = (sesi['guru'] ?? '').toLowerCase();
                    return mapel.contains(query) || guru.contains(query);
                  }).toList();

                  if (items.isEmpty) return const SizedBox.shrink();

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Material(
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
                              vertical: 12,
                              horizontal: 20,
                            ),
                            color: const Color(0xFFF8F9FA),
                            child: Text(
                              'Hari $hari',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ),
                          const Divider(height: 1, color: AppColors.border),
                          ...items.map((sesi) => _buildBarisJadwal(sesi)),
                        ],
                      ),
                    ),
                  );
                }),

                // 5. Informasi Istirahat
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFBEB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFFDE68A)),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 18,
                        color: Color(0xFFB45309),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Catatan: Istirahat I pukul 09.40 - 10.10 WIB • Ishoma Dzuhur pukul 12.15 - 13.00 WIB.',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: Color(0xFF92400E),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBarisJadwal(JadwalItem sesi) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Kolom Waktu
          SizedBox(
            width: 110,
            child: Text(
              sesi['waktu'] ?? '',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          // Kolom Mapel, Guru, & Ruangan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sesi['mapel'] ?? '',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.person_outline,
                        size: 14, color: AppColors.muted),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        sesi['guru'] ?? '',
                        style: const TextStyle(
                          fontSize: 12.5,
                          color: AppColors.muted,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.room_outlined,
                        size: 14, color: AppColors.muted),
                    const SizedBox(width: 4),
                    Text(
                      sesi['ruang'] ?? '',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
