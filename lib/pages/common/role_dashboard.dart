import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/user_role.dart';
import '../../widgets/app_sidebar.dart';
import '../../widgets/dashboard_card.dart';
import '../../widgets/menu_item.dart';
import '../auth/login_page.dart';
import 'feature_page.dart';

class RoleDashboard extends StatefulWidget {
  final UserRole role;
  final List<MenuItemData> menus;

  const RoleDashboard({super.key, required this.role, required this.menus});

  @override
  State<RoleDashboard> createState() => _RoleDashboardState();
}

class _RoleDashboardState extends State<RoleDashboard> {
  int _selectedIndex = 0;

  void _logout() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  Widget _content() {
    if (_selectedIndex == 0) {
      return _dashboardHome();
    }
    final item = widget.menus[_selectedIndex];
    return FeaturePage(
      title: item.title,
      description: item.description,
      icon: item.icon,
    );
  }

  Widget _dashboardHome() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat Datang, ${widget.role.label}!',
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w800,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Berikut ringkasan aktivitas pada sistem sekolah.',
            style: TextStyle(color: AppColors.muted),
          ),
          const SizedBox(height: 22),
          LayoutBuilder(
            builder: (context, constraints) {
              final columns = constraints.maxWidth > 900
                  ? 4
                  : constraints.maxWidth > 560
                      ? 2
                      : 1;
              return GridView.count(
                crossAxisCount: columns,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: columns == 1 ? 2.8 : 1.45,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  DashboardCard(
                    title: 'Informasi',
                    value: 'Aktif',
                    caption: 'Status aplikasi demo',
                    icon: Icons.info_outline,
                  ),
                  DashboardCard(
                    title: 'Modul',
                    value: '05',
                    caption: 'Modul contoh tersedia',
                    icon: Icons.widgets_outlined,
                    color: AppColors.success,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 26),
          const Text(
            'Menu Utama',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 14),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: MediaQuery.sizeOf(context).width > 850 ? 3 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.35,
            ),
            itemCount: widget.menus.length - 1,
            itemBuilder: (context, index) {
              final actualIndex = index + 1;
              final item = widget.menus[actualIndex];
              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => setState(() => _selectedIndex = actualIndex),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.icon, color: AppColors.primary, size: 28),
                        const SizedBox(height: 12),
                        Text(
                          item.title,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.sizeOf(context).width >= 800;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0
              ? 'Dashboard ${widget.role.label}'
              : widget.menus[_selectedIndex].title,
        ),
        actions: [
          IconButton(
            tooltip: 'Keluar',
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          ),
          const SizedBox(width: 8),
        ],
      ),
      drawer: isWide
          ? null
          : Drawer(
              child: AppSidebar(
                role: widget.role,
                items: widget.menus,
                selectedIndex: _selectedIndex,
                onSelected: (index) {
                  setState(() => _selectedIndex = index);
                  Navigator.pop(context);
                },
                onLogout: _logout,
              ),
            ),
      body: Row(
        children: [
          if (isWide)
            AppSidebar(
              role: widget.role,
              items: widget.menus,
              selectedIndex: _selectedIndex,
              onSelected: (index) => setState(() => _selectedIndex = index),
              onLogout: _logout,
            ),
          Expanded(child: _content()),
        ],
      ),
    );
  }
}
