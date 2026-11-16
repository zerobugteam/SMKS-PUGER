import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/app_colors.dart';

typedef TagihanSppItem = Map<String, String>;
typedef RiwayatDaftarUlang = Map<String, String>;

class DaftarUlangPage extends StatefulWidget {
  final int initialTab; // 0 = Biaya SPP, 1 = Daftar Ulang
  const DaftarUlangPage({super.key, this.initialTab = 1});

  @override
  State<DaftarUlangPage> createState() => _DaftarUlangPageState();
}

class _DaftarUlangPageState extends State<DaftarUlangPage> {
  late final int _activeTab = widget.initialTab;
  final ImagePicker _picker = ImagePicker();

  // --- State Biaya SPP ---
  final List<TagihanSppItem> _daftarSpp = [
    {
      'bulan': 'November 2026',
      'nominal': 'Rp 175.000',
      'jatuhTempo': '10 Nov 2026',
      'status': 'Belum Lunas',
      'bukti': '-',
    },
    {
      'bulan': 'Oktober 2026',
      'nominal': 'Rp 175.000',
      'jatuhTempo': '10 Okt 2026',
      'status': 'Lunas',
      'bukti': 'Transfer Bank Jatim (08 Okt 2026)',
    },
    {
      'bulan': 'September 2026',
      'nominal': 'Rp 175.000',
      'jatuhTempo': '10 Sep 2026',
      'status': 'Lunas',
      'bukti': 'Transfer Bank Jatim (05 Sep 2026)',
    },
    {
      'bulan': 'Agustus 2026',
      'nominal': 'Rp 175.000',
      'jatuhTempo': '10 Agu 2026',
      'status': 'Lunas',
      'bukti': 'Tunai Loket TU (09 Agu 2026)',
    },
  ];

  // --- State Daftar Ulang & Upload Berkas ---
  final TextEditingController _noWaCtrl = TextEditingController(
    text: '081229523471',
  );
  final TextEditingController _alamatCtrl = TextEditingController(
    text: 'Desa Puger Kulon, Dusun Gedangan, Kec. Puger / 68164',
  );
  final TextEditingController _namaWaliCtrl = TextEditingController(
    text: 'Budi Santoso',
  );

  String _selectedSemester = 'Semester Genap 2026/2027 (Kelas XI TKJ 2)';
  String _metodeBayarDaftarUlang = 'Transfer Bank Jatim (No. Rek: 0032948120)';
  bool _setujuPernyataan = true;

  // File Berkas & Bukti Bayar Daftar Ulang
  String? _fileKartuKeluarga;
  String? _fileRaporTerakhir;
  String? _fileKartuPelajar;
  String? _fileBuktiBayarDaftarUlang;

  static const List<String> _daftarSemester = [
    'Semester Genap 2026/2027 (Kelas XI TKJ 2)',
    'Semester Ganjil 2027/2028 (Kenaikan Kelas XII TKJ 2)',
  ];

  static const List<String> _opsiMetodeBayar = [
    'Transfer Bank Jatim (No. Rek: 0032948120)',
    'Transfer BRI Virtual Account SMKS Puger',
    'Bayar Tunai di Loket Tata Usaha Sekolah',
  ];

  final List<RiwayatDaftarUlang> _riwayatDaftarUlang = [
    {
      'semester': 'Semester Ganjil 2026/2027 (Kelas XI TKJ 2)',
      'biaya': 'Rp 450.000 (Lunas)',
      'berkas': 'KK, Rapor & Kartu Pelajar Lengkap',
      'status': 'Terverifikasi',
    },
  ];

  @override
  void dispose() {
    _noWaCtrl.dispose();
    _alamatCtrl.dispose();
    _namaWaliCtrl.dispose();
    super.dispose();
  }

  Future<void> _uploadDokumen(void Function(String fileName) onSelected) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (file == null) return;
      if (!mounted) return;
      setState(() => onSelected(file.name));
      _tampilPesan('Berkas "${file.name}" berhasil diunggah.');
    } catch (_) {
      if (!mounted) return;
      _tampilPesan('Gagal memilih berkas dari perangkat.', isError: true);
    }
  }

  Future<void> _bayarTagihanSpp(int index) async {
    try {
      final XFile? file = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (file == null || !mounted) return;

      setState(() {
        _daftarSpp[index]['status'] = 'Menunggu Verifikasi TU';
        _daftarSpp[index]['bukti'] = 'Bukti Transfer: ${file.name}';
      });
      _tampilPesan(
        'Bukti pembayaran SPP ${_daftarSpp[index]['bulan']} berhasil diunggah.',
      );
    } catch (_) {
      if (!mounted) return;
      _tampilPesan('Gagal mengunggah bukti pembayaran SPP.', isError: true);
    }
  }

  void _ajukanDaftarUlang() {
    if (_noWaCtrl.text.trim().isEmpty || _alamatCtrl.text.trim().isEmpty) {
      _tampilPesan(
        'Nomor WhatsApp aktif dan alamat domisili wajib diisi.',
        isError: true,
      );
      return;
    }
    if (_fileKartuKeluarga == null || _fileRaporTerakhir == null) {
      _tampilPesan(
        'Wajib mengunggah scan/foto Kartu Keluarga dan Rapor Terakhir.',
        isError: true,
      );
      return;
    }
    final isTunai = _metodeBayarDaftarUlang.contains('Tunai');
    if (!isTunai && _fileBuktiBayarDaftarUlang == null) {
      _tampilPesan(
        'Unggah bukti pembayaran biaya Daftar Ulang terlebih dahulu.',
        isError: true,
      );
      return;
    }
    if (!_setujuPernyataan) {
      _tampilPesan(
        'Centang pernyataan kebenaran data terlebih dahulu.',
        isError: true,
      );
      return;
    }

    setState(() {
      _riwayatDaftarUlang.insert(0, {
        'semester': _selectedSemester,
        'biaya': isTunai
            ? 'Rp 450.000 (Bayar Tunai TU)'
            : 'Rp 450.000 (Bukti: $_fileBuktiBayarDaftarUlang)',
        'berkas':
            'KK ($_fileKartuKeluarga), Rapor ($_fileRaporTerakhir)${_fileKartuPelajar != null ? ', Kartu Pelajar' : ''}',
        'status': 'Menunggu Validasi TU',
      });
      _fileKartuKeluarga = null;
      _fileRaporTerakhir = null;
      _fileKartuPelajar = null;
      _fileBuktiBayarDaftarUlang = null;
    });

    _tampilPesan(
      'Berkas & pembayaran Daftar Ulang berhasil dikirim ke Tata Usaha.',
    );
  }

  void _tampilPesan(String pesan, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(pesan),
        backgroundColor: isError ? AppColors.danger : AppColors.success,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDaftarUlang = _activeTab == 1;

    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  isDaftarUlang
                      ? 'Daftar Ulang & Unggah Berkas'
                      : 'Pembayaran Biaya SPP Bulanan',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isDaftarUlang
                      ? 'Registrasi ulang semester, biaya daftar ulang, dan unggah berkas persyaratan'
                      : 'Rincian tagihan SPP bulanan dan unggah bukti pembayaran SMKS Puger',
                  style: const TextStyle(fontSize: 13, color: AppColors.muted),
                ),
                const SizedBox(height: 18),
                if (isDaftarUlang)
                  _buildDaftarUlangSection()
                else
                  _buildBiayaSppSection(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // =========================================================================
  // TAMPILAN 1: BIAYA SPP BULANAN
  // =========================================================================
  Widget _buildBiayaSppSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Ringkasan Tagihan SPP
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: const Color(0xFF0F294A),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TARIF SPP BULANAN • KELAS XI TKJ 2',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFFBBF24),
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Rp 175.000 / Bulan',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Rekening Sekolah: Bank Jatim 0032948120 a.n. SMKS Puger Jember',
                      style: TextStyle(fontSize: 12, color: Color(0xFFCBD5E1)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Daftar Tagihan SPP per Bulan
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
                  'Daftar Tagihan & Riwayat SPP Semester Ganjil 2026/2027',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
              ),
              const Divider(height: 1, color: AppColors.border),
              for (int i = 0; i < _daftarSpp.length; i++) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 18,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SPP Bulan ${_daftarSpp[i]['bulan']}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.text,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Nominal: ${_daftarSpp[i]['nominal']}  •  Jatuh Tempo: ${_daftarSpp[i]['jatuhTempo']}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.muted,
                              ),
                            ),
                            if (_daftarSpp[i]['bukti'] != '-') ...[
                              const SizedBox(height: 2),
                              Text(
                                _daftarSpp[i]['bukti'] ?? '',
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: AppColors.primaryDark,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (_daftarSpp[i]['status'] == 'Belum Lunas')
                        FilledButton.icon(
                          onPressed: () => _bayarTagihanSpp(i),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                          ),
                          icon: const Icon(Icons.upload_file_rounded, size: 17),
                          label: const Text(
                            'Upload Bukti Bayar',
                            style: TextStyle(fontSize: 12.5),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: (_daftarSpp[i]['status'] == 'Lunas'
                                    ? AppColors.success
                                    : AppColors.warning)
                                .withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _daftarSpp[i]['status'] ?? '',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w700,
                              color: _daftarSpp[i]['status'] == 'Lunas'
                                  ? AppColors.success
                                  : AppColors.warning,
                            ),
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
  // TAMPILAN 2: DAFTAR ULANG (BIAYA DAFTAR ULANG + UPLOAD BERKAS PERSYARATAN)
  // =========================================================================
  Widget _buildDaftarUlangSection() {
    final isTunai = _metodeBayarDaftarUlang.contains('Tunai');

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
                'Formulir Daftar Ulang & Upload Berkas',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const Divider(height: 22, color: AppColors.border),

              // 1. Periode Semester
              const Text(
                'Periode Semester / Kenaikan Kelas',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.muted,
                ),
              ),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: _selectedSemester,
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
                items: _daftarSemester
                    .map(
                      (s) => DropdownMenuItem(
                        value: s,
                        child: Text(s, style: const TextStyle(fontSize: 13.5)),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedSemester = val);
                },
              ),
              const SizedBox(height: 12),

              // 2. Data Kontak & Wali
              TextField(
                controller: _noWaCtrl,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Nomor Telepon / WhatsApp Aktif',
                  labelStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _namaWaliCtrl,
                decoration: InputDecoration(
                  labelText: 'Nama Orang Tua / Wali Murid',
                  labelStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _alamatCtrl,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Alamat Domisili Terkini',
                  labelStyle: const TextStyle(fontSize: 13),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              // 3. Upload Berkas Persyaratan Daftar Ulang
              const Divider(height: 26, color: AppColors.border),
              const Text(
                'Upload Berkas Persyaratan Daftar Ulang',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppColors.text,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Unggah hasil foto atau scan dokumen yang jelas (Format JPG/PNG).',
                style: TextStyle(fontSize: 12, color: AppColors.muted),
              ),
              const SizedBox(height: 10),

              _buildUploadRow(
                label: '1. Scan / Foto Kartu Keluarga (KK) *',
                fileName: _fileKartuKeluarga,
                onPressed: () =>
                    _uploadDokumen((name) => _fileKartuKeluarga = name),
              ),
              const SizedBox(height: 10),
              _buildUploadRow(
                label: '2. Scan / Foto Rapor Semester Terakhir *',
                fileName: _fileRaporTerakhir,
                onPressed: () =>
                    _uploadDokumen((name) => _fileRaporTerakhir = name),
              ),
              const SizedBox(height: 10),
              _buildUploadRow(
                label: '3. Foto Kartu Pelajar SMKS Puger (Opsional)',
                fileName: _fileKartuPelajar,
                onPressed: () =>
                    _uploadDokumen((name) => _fileKartuPelajar = name),
              ),

              // 4. Pembayaran Biaya Daftar Ulang
              const Divider(height: 26, color: AppColors.border),
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
                          'Biaya Daftar Ulang Semester',
                          style: TextStyle(
                            fontSize: 13.5,
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                          ),
                        ),
                        Text(
                          'Rp 450.000',
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
                      'Mencakup biaya praktikum bengkel TKJ, perpustakaan, dan administrasi semester.',
                      style: TextStyle(fontSize: 11.5, color: AppColors.muted),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _metodeBayarDaftarUlang,
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
                      items: _opsiMetodeBayar
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
                        if (val != null) {
                          setState(() => _metodeBayarDaftarUlang = val);
                        }
                      },
                    ),
                    if (!isTunai) ...[
                      const SizedBox(height: 10),
                      _buildUploadRow(
                        label: 'Upload Bukti Pembayaran Daftar Ulang *',
                        fileName: _fileBuktiBayarDaftarUlang,
                        onPressed: () => _uploadDokumen(
                          (name) => _fileBuktiBayarDaftarUlang = name,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 10),
              CheckboxListTile(
                value: _setujuPernyataan,
                onChanged: (val) =>
                    setState(() => _setujuPernyataan = val ?? false),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text(
                  'Saya menyatakan berkas yang diunggah dan data di atas adalah benar dan sah.',
                  style: TextStyle(fontSize: 12.5, color: AppColors.text),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.icon(
                  onPressed: _ajukanDaftarUlang,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  icon: const Icon(Icons.how_to_reg_rounded, size: 18),
                  label: const Text('Kirim Daftar Ulang & Berkas'),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Riwayat Status Daftar Ulang
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
                  'Riwayat & Status Daftar Ulang',
                  style: TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  ),
                ),
              ),
              const Divider(height: 1, color: AppColors.border),
              for (final item in _riwayatDaftarUlang) ...[
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
                              item['semester'] ?? '',
                              style: const TextStyle(
                                fontSize: 13.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.text,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Biaya: ${item['biaya']}  •  Berkas: ${item['berkas']}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: AppColors.muted,
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
                          color: item['status'] == 'Terverifikasi'
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

  Widget _buildUploadRow({
    required String label,
    required String? fileName,
    required VoidCallback onPressed,
  }) {
    final hasFile = fileName != null;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: hasFile ? AppColors.success : AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Icon(
            hasFile ? Icons.check_circle_rounded : Icons.description_outlined,
            size: 20,
            color: hasFile ? AppColors.success : AppColors.muted,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 1),
                Text(
                  fileName ?? 'Belum ada file dipilih',
                  style: TextStyle(
                    fontSize: 11.5,
                    color: hasFile ? AppColors.success : AppColors.muted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          OutlinedButton(
            onPressed: onPressed,
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            child: Text(
              hasFile ? 'Ganti File' : 'Upload File',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
