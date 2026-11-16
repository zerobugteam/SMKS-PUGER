import 'package:flutter/material.dart';
import '../common/feature_page.dart';

class LaporanSekolahPage extends StatelessWidget {
  const LaporanSekolahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePage(
      title: 'Laporan Sekolah',
      description: 'Laporan akademik dan administrasi sekolah.',
      icon: Icons.assessment_outlined,
    );
  }
}
