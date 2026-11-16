import 'package:flutter/material.dart';
import '../../core/app_colors.dart';

class FeaturePage extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const FeaturePage({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Icon(icon, size: 38, color: AppColors.primary),
                ),
                const SizedBox(height: 20),
                Text(title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.text)),
                const SizedBox(height: 10),
                Text(description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: AppColors.muted, height: 1.5)),
                const SizedBox(height: 18),
                const Chip(
                  avatar: Icon(Icons.construction, size: 17),
                  label: Text('Modul dalam tahap pengembangan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
