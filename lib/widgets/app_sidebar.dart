import 'package:flutter/material.dart';
import '../core/app_colors.dart';
import '../core/user_role.dart';
import 'menu_item.dart';

class AppSidebar extends StatelessWidget {
  final UserRole role;
  final List<MenuItemData> items;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final VoidCallback onLogout;

  const AppSidebar({
    super.key,
    required this.role,
    required this.items,
    required this.selectedIndex,
    required this.onSelected,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: Colors.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 26, 20, 22),
            child: Row(
              children: [
                const Icon(Icons.school_rounded,
                    color: AppColors.primary, size: 34),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text('SMK PUGER\nDIGITAL',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                          height: 1.25)),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.primary.withValues(alpha: .1),
                  child: Icon(role.icon, color: AppColors.primary),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(role.label,
                      style: const TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: items.length,
              itemBuilder: (context, index) => MenuItemTile(
                item: items[index],
                selected: selectedIndex == index,
                onTap: () => onSelected(index),
              ),
            ),
          ),
          const Divider(height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.danger),
            title: const Text('Keluar'),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
