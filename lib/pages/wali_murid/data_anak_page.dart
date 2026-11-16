import 'package:flutter/material.dart';
import '../common/feature_page.dart';

class DataAnakPage extends StatelessWidget {
  const DataAnakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePage(
      title: 'Data Anak',
      description: 'Informasi siswa yang terhubung dengan wali.',
      icon: Icons.child_care_outlined,
    );
  }
}
