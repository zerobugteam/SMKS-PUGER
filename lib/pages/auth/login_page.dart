import 'package:flutter/material.dart';
import '../../core/app_colors.dart';
import '../../core/user_role.dart';
import '../../services/auth_service.dart';
import '../../widgets/app_header.dart';
import '../guru/guru_dashboard.dart';
import '../siswa/siswa_dashboard.dart';
import '../tu/tu_dashboard.dart';
import '../kepala_sekolah/kepsek_dashboard.dart';
import '../wali_murid/wali_dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _username = TextEditingController();
  final _password = TextEditingController();
  UserRole _role = UserRole.siswa;
  bool _obscure = true;
  bool _loading = false;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    final result = await AuthService().login(
      username: _username.text.trim(),
      password: _password.text,
      role: _role,
    );
    if (!mounted) return;
    setState(() => _loading = false);

    if (!result.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message)),
      );
      return;
    }

    final Widget destination;
    switch (_role) {
      case UserRole.siswa:
        destination = const SiswaDashboard();
      case UserRole.guru:
        destination = const GuruDashboard();
      case UserRole.tu:
        destination = const TuDashboard();
      case UserRole.kepalaSekolah:
        destination = const KepsekDashboard();
      case UserRole.waliMurid:
        destination = const WaliDashboard();
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(28),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const AppHeader(
                          title: 'SMK PUGER DIGITAL',
                          subtitle: 'Masuk ke akun Anda',
                          centered: true,
                        ),
                        const SizedBox(height: 28),
                        DropdownButtonFormField<UserRole>(
                          initialValue: _role,
                          decoration: const InputDecoration(
                            labelText: 'Masuk sebagai',
                            prefixIcon: Icon(Icons.people_alt_outlined),
                          ),
                          items: UserRole.values.map((role) {
                            return DropdownMenuItem(
                              value: role,
                              child: Text(role.label),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (value != null) setState(() => _role = value);
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _username,
                          decoration: const InputDecoration(
                            labelText: 'Username / NIS / NIP',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) =>
                              value == null || value.trim().isEmpty
                                  ? 'Username wajib diisi'
                                  : null,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _password,
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  setState(() => _obscure = !_obscure),
                              icon: Icon(_obscure
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined),
                            ),
                          ),
                          validator: (value) =>
                              value == null || value.isEmpty
                                  ? 'Password wajib diisi'
                                  : null,
                        ),
                        const SizedBox(height: 24),
                        FilledButton(
                          onPressed: _loading ? null : _login,
                          style: FilledButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: _loading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Masuk'),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Mode demo: isi username dan password apa saja. '
                          'Autentikasi server belum diaktifkan.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
