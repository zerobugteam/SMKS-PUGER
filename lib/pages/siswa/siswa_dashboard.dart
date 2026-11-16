import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import '../../core/app_colors.dart';
import '../auth/login_page.dart';
import 'absensi_siswa_page.dart';
import 'daftar_ulang_page.dart';
import 'ganti_sandi_page.dart';
import 'jadwal_siswa_page.dart';
import 'magang_siswa_page.dart';
import 'nilai_siswa_page.dart';
import 'panduan_siswa_page.dart';

typedef InfoEntry = MapEntry<String, String>;

class SiswaDashboard extends StatefulWidget {
  const SiswaDashboard({super.key});

  @override
  State<SiswaDashboard> createState() => _SiswaDashboardState();
}

class _SiswaDashboardState extends State<SiswaDashboard> {
  int _selectedIndex = 0;
  late final ScrollController _scrollController;
  bool _isBottomNavVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (!_scrollController.hasClients) return;
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.reverse) {
      if (_isBottomNavVisible) setState(() => _isBottomNavVisible = false);
    } else if (direction == ScrollDirection.forward) {
      if (!_isBottomNavVisible) setState(() => _isBottomNavVisible = true);
    }
  }

  static const List<InfoEntry> _dataPribadi = [
    MapEntry('NIK', '3509081405090004'),
    MapEntry('Tempat, Tanggal Lahir', 'JEMBER, 14-05-2009'),
    MapEntry('Jenis Kelamin', 'Laki-Laki'),
    MapEntry('No. Telepon / WA', '081229523471'),
    MapEntry('Email Sekolah', '20240108@smk-puger.sch.id'),
    MapEntry('Alamat Domisili',
        'Desa Puger Kulon, Dusun Gedangan, Kec. Puger / 68164'),
  ];

  static const List<InfoEntry> _dataAkademik = [
    MapEntry('NIS / NISN', '240108 / 0094827163'),
    MapEntry('Konsentrasi Keahlian', 'Teknik Komputer dan Jaringan (TKJ)'),
    MapEntry('Kelas / Semester', 'XI TKJ 2  •  Semester 1 (Ganjil)'),
    MapEntry('Wali Kelas', 'Yogiswara, S.T., Gr.'),
    MapEntry('Pembimbing PKL', 'Lalitya Nindita Sahenda, S.Pd.'),
    MapEntry('Tempat PKL / Prakerin', 'PT Sinovasi Idea Karya Jember'),
  ];

  String get _pageTitle {
    switch (_selectedIndex) {
      case 1:
        return 'Absensi Kehadiran';
      case 2:
        return 'Nilai Semester';
      case 3:
        return 'Jadwal Pelajaran';
      default:
        return 'Dashboard Siswa';
    }
  }

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  void _copyText(String label, String value) {
    Clipboard.setData(ClipboardData(text: value));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label ($value) disalin.'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  // Modal Menu Lainnya (Dibungkus Material & Scaffold agar 100% aman)
  void _showMoreMenuModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext sheetContext) {
        return Material(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Menu Layanan Akademik',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppColors.text,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 20),
                          onPressed: () => Navigator.pop(sheetContext),
                        ),
                      ],
                    ),
                    const Divider(height: 16, color: AppColors.border),
                    _menuItemModal(
                      icon: Icons.app_registration_rounded,
                      title: 'Pendaftaran Magang',
                      onTap: () {
                        Navigator.pop(sheetContext);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Scaffold(
                              body: MagangPage(
                                key: ValueKey('pendaftaran'),
                                initialTab: 1,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    _menuItemModal(
                      icon: Icons.assignment_turned_in_outlined,
                      title: 'Pelaksanaan Magang / PKL',
                      onTap: () {
                        Navigator.pop(sheetContext);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Scaffold(
                              body: MagangPage(
                                key: ValueKey('pelaksanaan'),
                                initialTab: 0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    _menuItemModal(
                      icon: Icons.payments_outlined,
                      title: 'Biaya SPP & Keuangan',
                      onTap: () {
                        Navigator.pop(sheetContext);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Scaffold(
                              body: DaftarUlangPage(
                                key: ValueKey('biaya_spp'),
                                initialTab: 0,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    _menuItemModal(
                      icon: Icons.how_to_reg_outlined,
                      title: 'Daftar Ulang Semester',
                      onTap: () {
                        Navigator.pop(sheetContext);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Scaffold(
                              body: DaftarUlangPage(
                                key: ValueKey('daftar_ulang'),
                                initialTab: 1,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    _menuItemModal(
                      icon: Icons.menu_book_outlined,
                      title: 'Panduan & Peraturan Siswa',
                      onTap: () {
                        Navigator.pop(sheetContext);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Scaffold(
                              body: PanduanSiswaPage(),
                            ),
                          ),
                        );
                      },
                    ),
                    _menuItemModal(
                      icon: Icons.lock_reset_rounded,
                      title: 'Ganti Kata Sandi',
                      onTap: () {
                        Navigator.pop(sheetContext);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const Scaffold(
                              body: GantiSandiPage(),
                            ),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 20, color: AppColors.border),
                    _menuItemModal(
                      icon: Icons.logout_rounded,
                      title: 'Keluar Aplikasi',
                      isDanger: true,
                      onTap: () {
                        Navigator.pop(sheetContext);
                        _logout();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _menuItemModal({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: Row(
            children: [
              Icon(
                icon,
                color: isDanger ? AppColors.danger : AppColors.primary,
                size: 22,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDanger ? AppColors.danger : AppColors.text,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Setiap halaman aktif DIJAMIN memiliki Scaffold & Material pembungkus
  Widget _buildActivePage(bool isWide) {
    switch (_selectedIndex) {
      case 1:
        return const Scaffold(
          backgroundColor: AppColors.background,
          body: AbsensiPage(),
        );
      case 2:
        return const Scaffold(
          backgroundColor: AppColors.background,
          body: NilaiSemesterPage(),
        );
      case 3:
        return const Scaffold(
          backgroundColor: AppColors.background,
          body: JadwalPelajaranPage(),
        );
      default:
        return Scaffold(
          backgroundColor: AppColors.background,
          body: _fastDashboardList(isWide),
        );
    }
  }

  Widget _fastDashboardList(bool isWide) {
    return ListView(
      controller: _scrollController,
      padding: EdgeInsets.zero,
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0F294A), Color(0xFF1E3A8A)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              'Siswa Aktif',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18),
                            child: Image.asset(
                              'assets/images/logo_smk_puger.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                Icons.school_rounded,
                                size: 38,
                                color: Color(0xFF0F294A),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          'SMKS PUGER JEMBER',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 3),
                        const Text(
                          'Portal Akademik Peserta Didik',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF93C5FD),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 18),
                          child: Divider(color: Colors.white24, height: 1),
                        ),
                        const Text(
                          'Ahmad Zeki Saputra',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'XI TKJ 2  •  Teknik Komputer dan Jaringan  •  NIS: 240108',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFFBBF24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (isWide)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                            child:
                                _simpleInfoCard('Data Pribadi', _dataPribadi)),
                        const SizedBox(width: 18),
                        Expanded(
                            child: _simpleInfoCard(
                                'Data Akademik & PKL', _dataAkademik)),
                      ],
                    )
                  else ...[
                    _simpleInfoCard('Data Pribadi', _dataPribadi),
                    const SizedBox(height: 18),
                    _simpleInfoCard('Data Akademik & PKL', _dataAkademik),
                  ],
                ],
              ),
            ),
          ),
        ),
        _buildCenteredFooter(),
      ],
    );
  }

  Widget _simpleInfoCard(String title, List<InfoEntry> entries) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const Divider(height: 22, color: AppColors.border),
          for (final item in entries)
            Padding(
              padding: const EdgeInsets.only(bottom: 11.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.key,
                    style:
                        const TextStyle(fontSize: 11.5, color: AppColors.muted),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.value,
                    style: const TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w600,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCenteredFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 28.0, horizontal: 20.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _socialCircleIcon(
                icon: Icons.camera_alt_outlined,
                tooltip: 'Instagram: @smkspuger_official',
                onTap: () => _copyText('Instagram', '@smkspuger_official'),
              ),
              _verticalDivider(),
              _socialCircleIcon(
                icon: Icons.play_arrow_rounded,
                tooltip: 'YouTube: SMKS Puger Official TV',
                onTap: () => _copyText('YouTube', 'SMKS Puger Official TV'),
              ),
              _verticalDivider(),
              _socialCircleIcon(
                icon: Icons.language_rounded,
                tooltip: 'Website: https://smk-puger.sch.id',
                onTap: () => _copyText('Website', 'https://smk-puger.sch.id'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'Pusat Informasi dan Layanan Akademik SMKS Puger',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 3),
          const Text(
            'Krajan I, Kasiyan Tim., Kec. Puger, Kabupaten Jember, Jawa Timur 68164',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _socialCircleIcon({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFCBD5E1), width: 1.2),
          ),
          child: Icon(icon, size: 17, color: const Color(0xFF64748B)),
        ),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      height: 22,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: const Color(0xFFE2E8F0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 760;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.text,
        title: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: const Color(0xFF0F294A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.school_rounded,
                size: 18,
                color: Color(0xFFFBBF24),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              _pageTitle,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Keluar',
            onPressed: _logout,
            icon: const Icon(Icons.logout_rounded),
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: _buildActivePage(isWide),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            left: 0,
            right: 0,
            bottom: _isBottomNavVisible ? 0 : -80,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
                border: const Border(
                  top: BorderSide(color: AppColors.border, width: 1),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex > 3 ? 0 : _selectedIndex,
                onTap: (index) {
                  if (index == 4) {
                    _showMoreMenuModal(context);
                  } else {
                    setState(() => _selectedIndex = index);
                  }
                },
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: AppColors.muted,
                selectedFontSize: 11.5,
                unselectedFontSize: 11,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.dashboard_rounded),
                    label: 'Beranda',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.location_on_outlined),
                    label: 'Absensi',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.grade_outlined),
                    label: 'Nilai',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_month_outlined),
                    label: 'Jadwal',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu_rounded),
                    label: 'Lainnya',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
