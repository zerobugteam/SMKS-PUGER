import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import '../../core/app_colors.dart';

class JadwalItem {
  final String hari;
  final String jam;
  final String mataPelajaran;
  final String kelas;
  final String ruang;
  final String agendaDeadline;
  final String status;

  const JadwalItem({
    required this.hari,
    required this.jam,
    required this.mataPelajaran,
    required this.kelas,
    required this.ruang,
    required this.agendaDeadline,
    required this.status,
  });
}

class SoalUjianItem {
  final String id;
  final String jenis;
  final String mapel;
  final String kelas;
  String statusSoal;
  String? namaFilePdf;

  SoalUjianItem({
    required this.id,
    required this.jenis,
    required this.mapel,
    required this.kelas,
    required this.statusSoal,
    this.namaFilePdf,
  });
}

class PklItem {
  final String nama;
  final String dudi;
  final String pembimbing;
  final String status;

  PklItem(
      {required this.nama,
      required this.dudi,
      required this.pembimbing,
      required this.status});
}

class JadwalMengajarPage extends StatefulWidget {
  const JadwalMengajarPage({super.key});

  @override
  State<JadwalMengajarPage> createState() => _JadwalMengajarPageState();
}

class _JadwalMengajarPageState extends State<JadwalMengajarPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedHari = 'Senin';
  final List<String> _daftarHari = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat'
  ];

  final List<JadwalItem> _semuaJadwal = [
    const JadwalItem(
      hari: 'Senin',
      jam: '07:00 - 09:30 WIB',
      mataPelajaran: 'Teknologi Jaringan Berbasis Luas (WAN)',
      kelas: 'XI TKJ 2',
      ruang: 'Lab Jaringan TKJ 1',
      agendaDeadline: 'Batas Kumpul Tugas Modul 2 (Besok)',
      status: 'Selesai',
    ),
    const JadwalItem(
      hari: 'Selasa',
      jam: '07:00 - 09:30 WIB',
      mataPelajaran: 'Teknologi Layanan Jaringan (TLJ)',
      kelas: 'XI TKJ 2',
      ruang: 'Lab Jaringan TKJ 1',
      agendaDeadline: 'Upload Soal UTS Semester Ganjil',
      status: 'Berlangsung',
    ),
  ];

  final List<SoalUjianItem> _daftarSoal = [
    SoalUjianItem(
        id: '1',
        jenis: 'Soal Pembelajaran / Kuis Harian',
        mapel: 'WAN',
        kelas: 'XI TKJ 2',
        statusSoal: 'Aktif',
        namaFilePdf: 'Kuis_WAN_Modul1.pdf'),
    SoalUjianItem(
        id: '2',
        jenis: 'Pembuatan Soal UTS',
        mapel: 'WAN',
        kelas: 'XI TKJ 2',
        statusSoal: 'Draft Siap Uji'),
  ];

  final List<PklItem> _dudiList = [
    PklItem(
        nama: 'Ahmad Zeki S.',
        dudi: 'PT Telkom Akses Jember',
        pembimbing: 'Yogiswara, S.T., Gr.',
        status: 'Aktif / Jurnal Terisi'),
    PklItem(
        nama: 'Dewi Lestari',
        dudi: 'Data Center Kabupaten Jember',
        pembimbing: 'Yogiswara, S.T., Gr.',
        status: 'Aktif / Jurnal Terisi'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _unggahPdfSoal(SoalUjianItem soal) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: kIsWeb,
      );

      if (result != null && result.files.isNotEmpty) {
        final fileName = result.files.first.name;
        setState(() {
          soal.statusSoal = 'Sudah Diunggah';
          soal.namaFilePdf = fileName;
        });
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('File PDF soal "$fileName" berhasil diunggah.'),
              backgroundColor: AppColors.success),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Gagal memilih file PDF.'),
            backgroundColor: AppColors.danger),
      );
    }
  }

  void _dialogBuatSoal(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Buat Soal / Ujian & Upload PDF'),
          content: SizedBox(
            width: 420,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const TextField(
                    decoration: InputDecoration(
                        labelText: 'Judul Soal / Topik Kuis',
                        filled: true,
                        fillColor: AppColors.background)),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: 'Soal UTS',
                  decoration: const InputDecoration(
                      labelText: 'Jenis Evaluasi',
                      filled: true,
                      fillColor: AppColors.background),
                  items: ['Soal Pembelajaran / Kuis', 'Soal UTS', 'Soal UAS']
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (_) {},
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Batal')),
            FilledButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        'Soal baru berhasil dibuat. Silakan unggah PDF.')));
              },
              child: const Text('Simpan & Lanjut'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final jadwalFiltered =
        _semuaJadwal.where((j) => j.hari == _selectedHari).toList();

    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Jadwal Mengajar, Soal, & Monitoring PKL',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text)),
                const SizedBox(height: 2),
                const Text('Yogiswara, S.T., Gr. • SMKS Puger Jember',
                    style: TextStyle(fontSize: 13, color: AppColors.muted)),
                const SizedBox(height: 16),
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
                      Tab(text: 'Jadwal & Agenda'),
                      Tab(text: 'Pembuatan Soal & Upload PDF'),
                      Tab(text: 'Monitoring PKL Siswa'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 520,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // TAB 1: JADWAL & AGENDA
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _daftarHari.map((hari) {
                                  final isSelected = _selectedHari == hari;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: ChoiceChip(
                                      label: Text(hari),
                                      selected: isSelected,
                                      selectedColor: AppColors.primary,
                                      labelStyle: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : AppColors.text,
                                          fontWeight: FontWeight.w700),
                                      onSelected: (_) =>
                                          setState(() => _selectedHari = hari),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            const Divider(height: 20, color: AppColors.border),
                            Expanded(
                              child: jadwalFiltered.isEmpty
                                  ? const Center(
                                      child: Text(
                                          'Tidak ada jadwal pada hari ini.',
                                          style: TextStyle(
                                              color: AppColors.muted)))
                                  : ListView.separated(
                                      itemCount: jadwalFiltered.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 12),
                                      itemBuilder: (context, index) {
                                        final item = jadwalFiltered[index];
                                        return Container(
                                          padding: const EdgeInsets.all(14),
                                          decoration: BoxDecoration(
                                              color: AppColors.background,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: AppColors.border)),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(item.jam,
                                                      style: const TextStyle(
                                                          fontSize: 11.5,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: AppColors
                                                              .primary)),
                                                  Text(item.status,
                                                      style: const TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: AppColors
                                                              .success)),
                                                ],
                                              ),
                                              const SizedBox(height: 6),
                                              Text(item.mataPelajaran,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w800)),
                                              const SizedBox(height: 2),
                                              Text(
                                                  'Kelas: ${item.kelas} • Ruang: ${item.ruang}',
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: AppColors.muted)),
                                              const SizedBox(height: 8),
                                              Row(
                                                children: [
                                                  const Icon(
                                                      Icons.timer_outlined,
                                                      size: 14,
                                                      color: AppColors.danger),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                      'Agenda: ${item.agendaDeadline}',
                                                      style: const TextStyle(
                                                          fontSize: 11.5,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: AppColors
                                                              .danger)),
                                                ],
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

                      // TAB 2: PEMBUATAN SOAL & UPLOAD PDF
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
                                const Text('Buat Soal & Unggah Berkas PDF',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800)),
                                FilledButton.icon(
                                  onPressed: () => _dialogBuatSoal(context),
                                  icon: const Icon(Icons.add_rounded, size: 16),
                                  label: const Text('Buat Soal Baru'),
                                ),
                              ],
                            ),
                            const Divider(height: 20, color: AppColors.border),
                            Expanded(
                              child: ListView.separated(
                                itemCount: _daftarSoal.length,
                                separatorBuilder: (_, __) =>
                                    const SizedBox(height: 10),
                                itemBuilder: (context, idx) {
                                  final s = _daftarSoal[idx];
                                  final sudahAdaPdf = s.namaFilePdf != null;
                                  return Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: AppColors.background,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: AppColors.border)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(s.jenis,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      fontSize: 13)),
                                              Text(
                                                  sudahAdaPdf
                                                      ? 'PDF: ${s.namaFilePdf}'
                                                      : 'Belum ada file PDF diunggah',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: sudahAdaPdf
                                                          ? AppColors.success
                                                          : AppColors.danger)),
                                            ],
                                          ),
                                        ),
                                        OutlinedButton.icon(
                                          onPressed: () => _unggahPdfSoal(s),
                                          icon: const Icon(
                                              Icons.picture_as_pdf_rounded,
                                              size: 16,
                                              color: Colors.red),
                                          label: Text(sudahAdaPdf
                                              ? 'Ganti PDF'
                                              : 'Upload PDF'),
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

                      // TAB 3: MONITORING PKL SISWA
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border)),
                        child: ListView.separated(
                          itemCount: _dudiList.length,
                          separatorBuilder: (_, __) =>
                              const Divider(height: 16),
                          itemBuilder: (context, i) {
                            final item = _dudiList[i];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.nama,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                        color: AppColors.primary)),
                                const SizedBox(height: 2),
                                Text('Mitra DUDI: ${item.dudi}',
                                    style: const TextStyle(fontSize: 12.5)),
                                Text('Guru Pembimbing: ${item.pembimbing}',
                                    style: const TextStyle(
                                        fontSize: 12, color: AppColors.muted)),
                                const SizedBox(height: 4),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: AppColors.success
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Text(item.status,
                                      style: const TextStyle(
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.success)),
                                ),
                              ],
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
        ),
      ],
    );
  }
}
