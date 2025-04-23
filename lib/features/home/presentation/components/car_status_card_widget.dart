import 'package:flutter/material.dart';
import 'package:tes_express_app_new/core/routes/main_page.dart';
import 'package:tes_express_app_new/core/routes/route_constants.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/widgets/blue_button.dart';
import 'package:tes_express_app_new/features/home/presentation/components/big_step_item.dart';
import 'package:tes_express_app_new/features/home/presentation/components/sub_steps_progress_bar.dart';

class CarStatusCard extends StatelessWidget {
  const CarStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/lixiangl7.png'),
            fit: BoxFit.cover),
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Заголовок
          Text(
            'Ваш Lixiang L7 в пути!',
            style: AppTheme.displayMedium,
          ),

          // Подзаголовок
          Text(
            'Сейчас мы едем до вашего пункта назначения, готовьтесь получать Ваш автомобиль',
            style: AppTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          // Информация о пути
          // Наша кастомная строка статусов
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

          SizedBox(
            height: 340,
          ),
          BlueButton(
            text: 'Подробнее',
            onPressed: () {
              // Используем статический метод для навигации и переключения вкладки
              MainPage.navigateTo(context, RouteConstants.logistic,
                  subRoute: RouteConstants.logisticDetails);
            },
          )
        ],
      ),
    );
  }
}
