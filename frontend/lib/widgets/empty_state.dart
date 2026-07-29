import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class EmptyStateWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const EmptyStateWidget({
    super.key,
    this.title = 'No Data Available',
    this.description = 'There are no records to display at this time.',
    this.icon = Icons.inbox,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 64, color: AppTheme.textMuted),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 8),
            Text(description, textAlign: TextAlign.center, style: const TextStyle(color: AppTheme.textMuted)),
          ],
        ),
      ),
    );
  }
}
