import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool centered;

  const AppHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.centered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Container(
          width: 58,
          height: 58,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: .1),
            borderRadius: BorderRadius.circular(17),
          ),
          child: const Icon(Icons.school_rounded,
              color: AppColors.primary, size: 32),
        ),
        const SizedBox(height: 16),
        Text(title,
            textAlign: centered ? TextAlign.center : TextAlign.start,
            style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.w800,
                color: AppColors.text)),
        const SizedBox(height: 6),
        Text(subtitle,
            textAlign: centered ? TextAlign.center : TextAlign.start,
            style: const TextStyle(color: AppColors.muted)),
      ],
    );
  }
}
