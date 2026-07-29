import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final themeColor = color ?? AppTheme.primaryBlue;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: themeColor.withValues(alpha: 0.1),
            radius: 24,
            child: Icon(icon, color: themeColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title,
                  style:
                      const TextStyle(fontSize: 13, color: AppTheme.textMuted)),
              const SizedBox(height: 4),
              Text(value,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: themeColor)),
            ]),
          ),
        ],
      ),
    );
  }
}
