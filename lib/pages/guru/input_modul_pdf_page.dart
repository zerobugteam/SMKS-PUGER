import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class ModulItem {
  final String id;
  final String judul;
  final String mataPelajaran;
  final String kelas;
  final String namaFile;
  final String tanggalUpload;

  const ModulItem({
    required this.id,
    required this.judul,
    required this.mataPelajaran,
    required this.kelas,
    required this.namaFile,
    required this.tanggalUpload,
  });
}

class InputModulPdfPage extends StatefulWidget {
  const InputModulPdfPage({super.key});

  @override
  State<InputModulPdfPage> createState() => _InputModulPdfPageState();
}

class _InputModulPdfPageState extends State<InputModulPdfPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();

  String _selectedKelas = 'XI TKJ 2';
  String _selectedMapel = 'Teknologi Jaringan Berbasis Luas (WAN)';

  PlatformFile? _selectedPdfFile;
  bool _isUploading = false;

  final List<String> _daftarKelas = const ['XI TKJ 2', 'XII TKJ 1', 'X TKJ 1'];
  final List<String> _daftarMapel = const [
    'Teknologi Jaringan Berbasis Luas (WAN)',
    'Administrasi Infrastruktur Jaringan (AIJ)',
    'Teknologi Layanan Jaringan (TLJ)',
  ];

  final List<ModulItem> _daftarModul = [
    const ModulItem(
      id: '1',
      judul: 'Modul 1: Konfigurasi Routing BGP & OSPF',
      mataPelajaran: 'Teknologi Jaringan Berbasis Luas (WAN)',
      kelas: 'XI TKJ 2',
      namaFile: 'Modul_WAN_BGP_OSPF.pdf',
      tanggalUpload: '13 Nov 2026',
    ),
  ];

  @override
  void dispose() {
    _judulController.dispose();
    super.dispose();
  }

  Future<void> _pilihFilePdf() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: kIsWeb,
      );

      if (result != null && result.files.isNotEmpty) {
        setState(() {
          _selectedPdfFile = result.files.first;
        });
        _pesan('File PDF berhasil dipilih: ${_selectedPdfFile!.name}',
            AppColors.success);
      }
    } catch (e) {
      _pesan('Gagal memilih file PDF.', AppColors.danger);
    }
  }

  void _unggahModul() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedPdfFile == null) {
      _pesan('Mohon pilih file PDF modul terlebih dahulu.', AppColors.warning);
      return;
    }

    setState(() => _isUploading = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _daftarModul.insert(
          0,
          ModulItem(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            judul: _judulController.text.trim(),
            mataPelajaran: _selectedMapel,
            kelas: _selectedKelas,
            namaFile: _selectedPdfFile!.name,
            tanggalUpload: 'Hari Ini',
          ),
        );
        _isUploading = false;
        _judulController.clear();
        _selectedPdfFile = null;
      });

      _pesan('Modul Ajar PDF berhasil diunggah ke sistem.', AppColors.success);
    });
  }

  void _hapusModul(String id) {
    setState(() {
      _daftarModul.removeWhere((m) => m.id == id);
    });
    _pesan('Modul berhasil dihapus.', AppColors.primary);
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
                  'Input & Unggah Modul Ajar PDF',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Yogiswara, S.T., Gr. • Pusat Dokumen Pembelajaran Digital',
                  style: TextStyle(fontSize: 13, color: AppColors.muted),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Form Unggah Dokumen Modul',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: AppColors.text),
                        ),
                        const Divider(height: 20, color: AppColors.border),
                        TextFormField(
                          controller: _judulController,
                          decoration: InputDecoration(
                            labelText: 'Judul Modul Pembelajaran',
                            hintText:
                                'Contoh: Modul 3: Konfigurasi VLAN & Routing',
                            filled: true,
                            fillColor: AppColors.background,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                          validator: (val) => val == null || val.isEmpty
                              ? 'Judul modul wajib diisi'
                              : null,
                        ),
                        const SizedBox(height: 14),
                        // Dropdown Kelas & Mapel (Aman dari Overflow dengan Expanded)
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: DropdownButtonFormField<String>(
                                value: _selectedKelas,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  labelText: 'Kelas',
                                  filled: true,
                                  fillColor: AppColors.background,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                items: _daftarKelas.map((k) {
                                  return DropdownMenuItem(
                                    value: k,
                                    child: Text(k,
                                        overflow: TextOverflow.ellipsis),
                                  );
                                }).toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedKelas = val!),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              flex: 2,
                              child: DropdownButtonFormField<String>(
                                value: _selectedMapel,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  labelText: 'Mata Pelajaran',
                                  filled: true,
                                  fillColor: AppColors.background,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                ),
                                items: _daftarMapel.map((m) {
                                  return DropdownMenuItem(
                                    value: m,
                                    child: Text(
                                      m,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedMapel = val!),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        InkWell(
                          onTap: _pilihFilePdf,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _selectedPdfFile != null
                                    ? AppColors.success
                                    : AppColors.border,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.picture_as_pdf_rounded,
                                    color: Colors.redAccent, size: 32),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _selectedPdfFile != null
                                            ? _selectedPdfFile!.name
                                            : 'Pilih File Dokumen PDF (.pdf)',
                                        style: TextStyle(
                                          fontSize: 13.5,
                                          fontWeight: FontWeight.w700,
                                          color: _selectedPdfFile != null
                                              ? AppColors.text
                                              : AppColors.muted,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        _selectedPdfFile != null
                                            ? '${(_selectedPdfFile!.size / 1024).toStringAsFixed(1)} KB'
                                            : 'Maksimal ukuran file 25 MB',
                                        style: const TextStyle(
                                            fontSize: 11.5,
                                            color: AppColors.muted),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                OutlinedButton(
                                  onPressed: _pilihFilePdf,
                                  child: const Text('Cari'),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            onPressed: _isUploading ? null : _unggahModul,
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                            ),
                            icon: _isUploading
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                        color: Colors.white, strokeWidth: 2),
                                  )
                                : const Icon(Icons.cloud_upload_rounded),
                            label: Text(_isUploading
                                ? 'Mengunggah Modul...'
                                : 'Unggah Modul Pembelajaran'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Daftar Modul Terunggah',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.text),
                      ),
                      const Divider(height: 20, color: AppColors.border),
                      if (_daftarModul.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Text('Belum ada modul PDF yang diunggah.',
                                style: TextStyle(color: AppColors.muted)),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _daftarModul.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final modul = _daftarModul[index];
                            return Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.picture_as_pdf_rounded,
                                      color: Colors.red, size: 28),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          modul.judul,
                                          style: const TextStyle(
                                              fontSize: 13.5,
                                              fontWeight: FontWeight.w700),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          '${modul.mataPelajaran} • Kelas ${modul.kelas} • ${modul.namaFile}',
                                          style: const TextStyle(
                                              fontSize: 11.5,
                                              color: AppColors.muted),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                        Icons.delete_outline_rounded,
                                        color: AppColors.danger,
                                        size: 20),
                                    tooltip: 'Hapus Modul',
                                    onPressed: () => _hapusModul(modul.id),
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
}
