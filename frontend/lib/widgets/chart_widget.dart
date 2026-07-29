import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class ChartWidget extends StatelessWidget {
  final String title;
  final List<double> values;
  final List<String> labels;

  const ChartWidget({
    super.key,
    required this.title,
    required this.values,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    final maxValue = values.isEmpty ? 1.0 : values.reduce((a, b) => a > b ? a : b);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          SizedBox(
            height: 140,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(values.length, (index) {
                final heightFactor = (values[index] / (maxValue == 0 ? 1 : maxValue)).clamp(0.05, 1.0);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 24,
                      height: 100 * heightFactor,
                      decoration: BoxDecoration(color: AppTheme.accentBlue, borderRadius: BorderRadius.circular(4)),
                    ),
                    const SizedBox(height: 6),
                    Text(labels[index], style: const TextStyle(fontSize: 10, color: AppTheme.textMuted)),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
