import 'package:flutter/material.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';

class SubStepsProgressBar extends StatelessWidget {
  final int totalSubSteps; // Всего шагов (например, 3)
  final int completedSubSteps; // Сколько уже завершено (0..3)
  final double height;
  final Color backgroundColor;
  final Color progressColor;
  final BorderRadius? borderRadius;

  const SubStepsProgressBar({
    super.key,
    required this.totalSubSteps,
    required this.completedSubSteps,
    this.height = 6.0,
    this.backgroundColor = const Color.fromRGBO(217, 217, 217, 1),
    this.progressColor = AppTheme.green,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    // Защита от деления на ноль:
    final total = totalSubSteps <= 0 ? 1 : totalSubSteps;

    // Доля прогресса
    final progressFraction = (completedSubSteps / total).clamp(0.0, 1.0);

    return LayoutBuilder(
      builder: (context, constraints) {
        // Общая ширина доступная ProgressBar
        final totalWidth = constraints.maxWidth;

        // Ширина "зелёной" части
        final progressWidth = totalWidth * progressFraction;

        return Container(
          width: totalWidth,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: borderRadius ?? BorderRadius.circular(height / 0.1),
          ),
          child: Stack(
            children: [
              // Залитая часть
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: progressWidth,
                  decoration: BoxDecoration(
                    color: progressColor,
                    borderRadius:
                        borderRadius ?? BorderRadius.circular(height / 1),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
