import 'package:flutter/material.dart';
import '../common/feature_page.dart';

class DataSiswaPage extends StatelessWidget {
  const DataSiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePage(
      title: 'Data Siswa',
      description: 'Data induk siswa.',
      icon: Icons.school_outlined,
    );
  }
}
