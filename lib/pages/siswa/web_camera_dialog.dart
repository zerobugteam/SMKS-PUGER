// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:async';
import 'dart:html' as html;
import 'dart:typed_data';
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class WebCameraDialog extends StatefulWidget {
  const WebCameraDialog({super.key});

  @override
  State<WebCameraDialog> createState() => _WebCameraDialogState();
}

class _WebCameraDialogState extends State<WebCameraDialog> {
  late final String _viewId;
  html.VideoElement? _videoElement;
  html.MediaStream? _mediaStream;
  bool _isReady = false;
  String? _errorMsg;

  @override
  void initState() {
    super.initState();
    _viewId = 'webcam-view-${DateTime.now().millisecondsSinceEpoch}';
    _initWebcam();
  }

  Future<void> _initWebcam() async {
    try {
      _videoElement = html.VideoElement()
        ..autoplay = true
        ..muted = true
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.objectFit = 'cover'
        ..style.transform = 'scaleX(-1)'; // Efek cermin seperti kamera selfie

      ui_web.platformViewRegistry.registerViewFactory(
        _viewId,
        (int viewId) => _videoElement!,
      );

      final stream = await html.window.navigator.mediaDevices?.getUserMedia({
        'video': {'facingMode': 'user'},
        'audio': false,
      });

      if (stream == null) {
        setState(
          () => _errorMsg = 'Kamera tidak ditemukan pada perangkat ini.',
        );
        return;
      }

      _mediaStream = stream;
      _videoElement!.srcObject = stream;
      await _videoElement!.play();

      if (mounted) {
        setState(() => _isReady = true);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMsg =
              'Akses kamera ditolak. Izinkan akses kamera pada browser Chrome.';
        });
      }
    }
  }

  Future<void> _ambilGambar() async {
    final video = _videoElement;
    if (video == null || !_isReady) return;

    final width = video.videoWidth > 0 ? video.videoWidth : 640;
    final height = video.videoHeight > 0 ? video.videoHeight : 480;

    final canvas = html.CanvasElement(width: width, height: height);
    final ctx = canvas.context2D;

    // Balikkan horizontal agar hasil foto sesuai tampilan cermin selfie
    ctx.translate(width, 0);
    ctx.scale(-1, 1);
    ctx.drawImageScaled(video, 0, 0, width, height);

    final blob = await canvas.toBlob('image/jpeg', 0.8);
    final reader = html.FileReader();
    reader.readAsArrayBuffer(blob);
    await reader.onLoadEnd.first;

    final bytes = Uint8List.fromList(reader.result as List<int>);
    _stopStream();

    if (mounted) {
      Navigator.of(context).pop(bytes);
    }
  }

  void _stopStream() {
    _mediaStream?.getTracks().forEach((track) => track.stop());
    _mediaStream = null;
  }

  @override
  void dispose() {
    _stopStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      title: const Text(
        'Kamera Selfie Absensi',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
      ),
      content: SizedBox(
        width: 360,
        height: 280,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Colors.black,
            child: _errorMsg != null
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        _errorMsg!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      HtmlElementView(viewType: _viewId),
                      if (!_isReady)
                        const CircularProgressIndicator(color: Colors.white),
                    ],
                  ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _stopStream();
            Navigator.of(context).pop();
          },
          child: const Text('Batal'),
        ),
        FilledButton.icon(
          onPressed: _isReady ? _ambilGambar : null,
          style: FilledButton.styleFrom(backgroundColor: AppColors.primary),
          icon: const Icon(Icons.camera_alt_rounded, size: 18),
          label: const Text('Jepret Foto'),
        ),
      ],
    );
  }
}
