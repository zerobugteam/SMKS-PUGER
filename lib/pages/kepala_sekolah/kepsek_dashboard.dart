import 'package:flutter/material.dart';
import '../../core/user_role.dart';
import '../../widgets/menu_item.dart';
import '../common/role_dashboard.dart';

class KepsekDashboard extends StatelessWidget {
  const KepsekDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoleDashboard(
      role: UserRole.kepalaSekolah,
      menus: [
      MenuItemData('Dashboard', Icons.dashboard_rounded, 'Ringkasan dan statistik sekolah.'),
      MenuItemData('Monitoring Siswa', Icons.groups_outlined, 'Pemantauan data dan aktivitas siswa.'),
      MenuItemData('Monitoring Guru', Icons.supervisor_account_outlined, 'Pemantauan aktivitas guru.'),
      MenuItemData('Laporan Sekolah', Icons.assessment_outlined, 'Laporan akademik dan administrasi sekolah.')
      ],
    );
  }
}
