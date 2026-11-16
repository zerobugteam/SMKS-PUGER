import 'package:flutter/material.dart';
import '../common/feature_page.dart';

class ProfilSiswaPage extends StatelessWidget {
  const ProfilSiswaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePage(
      title: 'Profil Siswa',
      description: 'Informasi identitas dan data siswa.',
      icon: Icons.person_outline,
    );
  }
}
