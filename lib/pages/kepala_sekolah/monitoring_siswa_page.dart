import 'package:flutter/material.dart';
import '../common/feature_page.dart';

class MonitoringSiswaPage extends StatelessWidget {
  const MonitoringSiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePage(
      title: 'Monitoring Siswa',
      description: 'Pemantauan data dan aktivitas siswa.',
      icon: Icons.groups_outlined,
    );
  }
}
