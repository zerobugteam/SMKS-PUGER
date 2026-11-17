import 'dart:typed_data';
import 'package:flutter/material.dart';

class WebCameraDialog extends StatelessWidget {
  const WebCameraDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Kamera Web'),
      content: const Text('Kamera web hanya tersedia pada platform Web.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Tutup'),
        ),
      ],
    );
  }
}
