import 'package:flutter/material.dart';
import 'package:smk_puger_digital/pages/auth/login_page.dart'; // Impor halaman login Anda
import 'package:smk_puger_digital/core/app_colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistem Pendidikan Digital SMK Puger',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
      ),
      // Halaman pertama kali yang dibuka adalah Halaman Login
      home: const LoginPage(),
    );
  }
}
