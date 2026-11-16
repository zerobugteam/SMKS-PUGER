import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class PklItem {
  final String nama;
  final String dudi;
  final String pembimbing;
  final String status;

  PklItem({
    required this.nama,
    required this.dudi,
    required this.pembimbing,
    required this.status,
  });
}

class MonitoringPklPage extends StatelessWidget {
  const MonitoringPklPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<PklItem> dudiList = [
      PklItem(
          nama: 'Ahmad Zeki S.',
          dudi: 'PT Telkom Akses Jember',
          pembimbing: 'Yogiswara, S.T., Gr.',
          status: 'Aktif / Jurnal Terisi'),
      PklItem(
          nama: 'Dewi Lestari',
          dudi: 'Data Center Kabupaten Jember',
          pembimbing: 'Yogiswara, S.T., Gr.',
          status: 'Aktif / Jurnal Terisi'),
    ];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('7. Monitoring PKL / Magang Siswa',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                const Text(
                    'Daftar penempatan industri, guru pembimbing, dan jurnal kegiatan.',
                    style: TextStyle(fontSize: 13, color: AppColors.muted)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dudiList.length,
                    separatorBuilder: (_, __) => const Divider(height: 16),
                    itemBuilder: (context, i) {
                      final item = dudiList[i];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.nama,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: AppColors.primary)),
                          const SizedBox(height: 2),
                          Text('Mitra DUDI: ${item.dudi}',
                              style: const TextStyle(fontSize: 12.5)),
                          Text('Guru Pembimbing: ${item.pembimbing}',
                              style: const TextStyle(
                                  fontSize: 12, color: AppColors.muted)),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                                color: AppColors.success.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6)),
                            child: Text(item.status,
                                style: const TextStyle(
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.success)),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
