import 'package:flutter/material.dart';
import '../common/feature_page.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePage(
      title: 'Pengaturan',
      description: 'Konfigurasi sistem sekolah.',
      icon: Icons.settings_outlined,
    );
  }
}
