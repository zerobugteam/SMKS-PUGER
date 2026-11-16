import 'package:flutter/material.dart';
import '../common/feature_page.dart';

class ManajemenPenggunaPage extends StatelessWidget {
  const ManajemenPenggunaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePage(
      title: 'Manajemen Pengguna',
      description: 'Pengelolaan akun dan hak akses.',
      icon: Icons.manage_accounts_outlined,
    );
  }
}
