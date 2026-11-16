import 'package:flutter/material.dart';
import '../common/feature_page.dart';

class PembayaranPage extends StatelessWidget {
  const PembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const FeaturePage(
      title: 'Pembayaran',
      description: 'Informasi pembayaran sekolah.',
      icon: Icons.payments_outlined,
    );
  }
}
