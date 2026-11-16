import 'package:flutter/material.dart';

enum UserRole { siswa, guru, tu, kepalaSekolah, waliMurid }

extension UserRoleInfo on UserRole {
  String get label {
    switch (this) {
      case UserRole.siswa: return 'Siswa';
      case UserRole.guru: return 'Guru';
      case UserRole.tu: return 'Tata Usaha';
      case UserRole.kepalaSekolah: return 'Kepala Sekolah';
      case UserRole.waliMurid: return 'Wali Murid';
    }
  }

  IconData get icon {
    switch (this) {
      case UserRole.siswa: return Icons.school_rounded;
      case UserRole.guru: return Icons.cast_for_education_rounded;
      case UserRole.tu: return Icons.admin_panel_settings_rounded;
      case UserRole.kepalaSekolah: return Icons.account_balance_rounded;
      case UserRole.waliMurid: return Icons.family_restroom_rounded;
    }
  }
}
