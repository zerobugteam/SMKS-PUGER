import 'package:flutter/material.dart';

class MenuItemData {
  final String title;
  final IconData icon;
  final String description;

  const MenuItemData(this.title, this.icon, this.description);
}

class MenuItemTile extends StatelessWidget {
  final MenuItemData item;
  final bool selected;
  final VoidCallback onTap;

  const MenuItemTile({
    super.key,
    required this.item,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: selected,
      selectedTileColor: const Color(0xFFEAF2FC),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(item.icon),
      title: Text(item.title),
      onTap: onTap,
    );
  }
}
