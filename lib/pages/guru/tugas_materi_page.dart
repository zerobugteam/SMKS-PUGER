import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class TugasMateriPage extends StatelessWidget {
  const TugasMateriPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 960),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('6. Tugas & Materi Pembelajaran',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                const Text(
                    'Unggah modul, buat penugasan baru, dan tentukan tenggat waktu (deadline).',
                    style: TextStyle(fontSize: 13, color: AppColors.muted)),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.border)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Form Unggah Materi / Tugas Baru',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 14)),
                      const Divider(height: 20),
                      TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Judul Tugas / Modul Ajar',
                              filled: true,
                              fillColor: AppColors.background,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)))),
                      const SizedBox(height: 12),
                      TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Deskripsi & Instruksi Pengerjaan',
                              filled: true,
                              fillColor: AppColors.background,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          maxLines: 3),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () => ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                                content: Text(
                                    'Tugas dan materi berhasil dipublikasikan.'))),
                        icon: const Icon(Icons.cloud_upload_rounded),
                        label: const Text('Publikasikan ke Siswa'),
                      ),
                    ],
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
