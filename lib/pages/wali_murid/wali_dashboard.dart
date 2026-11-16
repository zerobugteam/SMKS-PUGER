import 'package:flutter/material.dart';
import '../../core/user_role.dart';
import '../../widgets/menu_item.dart';
import '../common/role_dashboard.dart';

class WaliDashboard extends StatelessWidget {
  const WaliDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const RoleDashboard(
      role: UserRole.waliMurid,
      menus: [
      MenuItemData('Dashboard', Icons.dashboard_rounded, 'Ringkasan informasi anak.'),
      MenuItemData('Data Anak', Icons.child_care_outlined, 'Informasi siswa yang terhubung dengan wali.'),
      MenuItemData('Kehadiran Anak', Icons.fact_check_outlined, 'Riwayat kehadiran anak.'),
      MenuItemData('Nilai Anak', Icons.grade_outlined, 'Nilai dan perkembangan belajar anak.'),
      MenuItemData('Pembayaran', Icons.payments_outlined, 'Informasi pembayaran sekolah.')
      ],
    );
  }
}
