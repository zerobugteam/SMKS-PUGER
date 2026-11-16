import 'package:flutter/material.dart';
import '../common/feature_page.dart';

class NilaiAnakPage extends StatelessWidget {
  const NilaiAnakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePage(
      title: 'Nilai Anak',
      description: 'Nilai dan perkembangan belajar anak.',
      icon: Icons.grade_outlined,
    );
  }
}
