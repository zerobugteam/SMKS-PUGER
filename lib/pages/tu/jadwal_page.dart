import 'package:flutter/material.dart';
import '../common/feature_page.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePage(
      title: 'Jadwal',
      description: 'Pengaturan jadwal pelajaran.',
      icon: Icons.calendar_month_outlined,
    );
  }
}
