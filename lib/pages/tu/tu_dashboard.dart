import 'package:flutter/material.dart';
import '../../core/user_role.dart';
import '../../widgets/menu_item.dart';
import '../common/role_dashboard.dart';

class TuDashboard extends StatelessWidget {
  const TuDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoleDashboard(
      role: UserRole.tu,
      menus: [
      MenuItemData('Dashboard', Icons.dashboard_rounded, 'Ringkasan administrasi sekolah.'),
      MenuItemData('Manajemen Pengguna', Icons.manage_accounts_outlined, 'Pengelolaan akun dan hak akses.'),
      MenuItemData('Data Siswa', Icons.school_outlined, 'Data induk siswa.'),
      MenuItemData('Data Guru', Icons.cast_for_education_outlined, 'Data tenaga pendidik.'),
      MenuItemData('Jadwal', Icons.calendar_month_outlined, 'Pengaturan jadwal pelajaran.'),
      MenuItemData('Pengaturan', Icons.settings_outlined, 'Konfigurasi sistem sekolah.')
      ],
    );
  }
}
