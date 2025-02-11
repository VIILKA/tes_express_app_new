import 'package:flutter/material.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';
import 'package:tes_test_app/core/widgets/blue_button.dart';
import 'package:tes_test_app/features/home/presentation/components/big_step_item.dart';
import 'package:tes_test_app/features/home/presentation/components/sub_steps_progress_bar.dart';

class CarStatusWithScaleBar extends StatelessWidget {
  final String title;
  final String vinCode;
  final String imagePath;
  final String status;
  final String deliveryDate;
  final VoidCallback onButtonPressed;
  const CarStatusWithScaleBar(
      {super.key,
      required this.title,
      required this.vinCode,
      required this.imagePath,
      required this.status,
      required this.deliveryDate,
      required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 260,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Верхняя часть с названием и кнопкой
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.displayMedium,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'VIN CODE: $vinCode',
                    style: AppTheme.bodyTiny.copyWith(
                      color: AppTheme.greyText,
                    ),
                  ),
                ],
              ),
              BlueButton(
                text: 'Посмотреть',
                onPressed: onButtonPressed,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Изображение автомобиля
          Spacer(),
          const SizedBox(height: 16.0),
          // Статус и даты доставки
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Большой шаг 1 (CBX (KZ), зеленый, т.к. уже достигнут)
              const BigStepItem(
                icon: Icons.apartment,
                label: 'CBX (KZ)',
                isCompleted: true,
              ),
              const SizedBox(width: 8),

              // Прогресс между CBX и Границей (3 мини-шага, 2 выполнены)
              Expanded(
                child: const SubStepsProgressBar(
                  totalSubSteps: 3,
                  completedSubSteps: 3,
                ),
              ),
              const SizedBox(width: 8),

              // Большой шаг 2 (Граница с РФ)
              const BigStepItem(
                icon: Icons.check_box,
                label: 'Граница с РФ',
                isCompleted: true, // или false - зависит от реального статуса
              ),
              const SizedBox(width: 8),

              // Прогресс между Границей и Получателем (2 мини-шагa, 0 выполнено)
              Expanded(
                child: const SubStepsProgressBar(
                  totalSubSteps: 3,
                  completedSubSteps: 2,
                ),
              ),
              const SizedBox(width: 8),

              // Большой шаг 3 (Получатель)
              const BigStepItem(
                icon: Icons.home_outlined,
                label: 'Получатель',
                isCompleted: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
