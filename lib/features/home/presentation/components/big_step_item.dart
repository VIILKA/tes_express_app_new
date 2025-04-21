import 'package:flutter/material.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';

class BigStepItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isCompleted;

  const BigStepItem({
    super.key,
    required this.icon,
    required this.label,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isCompleted ? AppTheme.green : AppTheme.grey;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTheme.bodyTiny.copyWith(color: color),
        ),
      ],
    );
  }
}
