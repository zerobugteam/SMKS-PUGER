import 'package:flutter/material.dart';
import '../common/feature_page.dart';

class KehadiranAnakPage extends StatelessWidget {
  const KehadiranAnakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePage(
      title: 'Kehadiran Anak',
      description: 'Riwayat kehadiran anak.',
      icon: Icons.fact_check_outlined,
    );
  }
}
