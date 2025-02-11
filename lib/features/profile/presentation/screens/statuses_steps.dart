import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';
import 'package:tes_test_app/core/widgets/circular_avatar.dart';
import 'package:tes_test_app/core/widgets/steps_card.dart';

class StatusesSteps extends StatelessWidget {
  const StatusesSteps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Записи',
                  style: AppTheme.displayLarge,
                ),
                CircularAvatar(
                  imageUrl: 'assets/images/avatar_cat.png',
                  size: 30.w,
                )
              ],
            ),
          ),
          StepCard(
            title: 'Составление контракта с китайцами',
            description: 'Оформление машины',
            startDate: '15.01.2025',
            endDate: '16.01.2025',
          ),
          StepCard(
            title: 'Оплата в Китай (SWIFT)',
            description: 'Перевод средств за автомобиль в Китай',
            startDate: '15.01.2025',
            endDate: '16.01.2025',
            delayMessage: 'Произошла задержка оплаты из-за праздников',
            delayDays: 2,
          ),
          StepCard(
            title: 'Договор с китайской стороной',
            description: 'Оформление машины',
            startDate: '15.01.2025',
            endDate: '16.01.2025',
          ),
          StepCard(
            title: 'Составление договора',
            description: 'Оформление клиента',
            startDate: '12.01.2025',
            endDate: '14.01.2025',
          ),
        ],
      )),
    );
  }
}
