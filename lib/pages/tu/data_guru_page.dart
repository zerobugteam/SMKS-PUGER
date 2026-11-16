import 'package:flutter/material.dart';
import '../common/feature_page.dart';

class DataGuruPage extends StatelessWidget {
  const DataGuruPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePage(
      title: 'Data Guru',
      description: 'Data tenaga pendidik.',
      icon: Icons.cast_for_education_outlined,
    );
  }
}
