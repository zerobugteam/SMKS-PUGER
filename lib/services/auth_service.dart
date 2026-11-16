import '../core/user_role.dart';

class AuthResult {
  final bool success;
  final String message;

  const AuthResult({required this.success, required this.message});
}

class AuthService {
  Future<AuthResult> login({
    required String username,
    required String password,
    required UserRole role,
  }) async {
    // DEMO ONLY. Ganti dengan validasi API Laravel saat backend tersedia.
    await Future.delayed(const Duration(milliseconds: 700));
    if (username.trim().isEmpty || password.isEmpty) {
      return const AuthResult(
        success: false,
        message: 'Username dan password harus diisi.',
      );
    }
    return const AuthResult(success: true, message: 'Login demo berhasil.');
  }
}
