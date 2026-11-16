import 'package:flutter/material.dart';
import '../common/feature_page.dart';

class MonitoringGuruPage extends StatelessWidget {
  const MonitoringGuruPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePage(
      title: 'Monitoring Guru',
      description: 'Pemantauan aktivitas guru.',
      icon: Icons.supervisor_account_outlined,
    );
  }
}
