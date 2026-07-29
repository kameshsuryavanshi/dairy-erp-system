import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class CustomDrawer extends StatelessWidget {
  final String userRole;

  const CustomDrawer({super.key, required this.userRole});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: AppTheme.primaryBlue),
            accountName: const Text('DairyFlow ERP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            accountEmail: Text('Role: ${userRole.toUpperCase()}'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.local_shipping, color: AppTheme.primaryBlue, size: 32),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.opacity),
            title: const Text('Milk Collection'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Expenses'),
            onTap: () => Navigator.pop(context),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
