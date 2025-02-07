import 'package:flutter/material.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';
import 'package:tes_test_app/features/logistic/presentation/screens/components/car_details_card.dart';

class LogisticPage extends StatefulWidget {
  const LogisticPage({super.key});

  @override
  State<LogisticPage> createState() => _LogisticPageState();
}

class _LogisticPageState extends State<LogisticPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Логистика',
                  style: AppTheme.displayLarge,
                ),
                Text(
                  'Сейчас мы едем до вашего пункта назначения,\nготовьтесь получать',
                  style: AppTheme.bodySmall.copyWith(color: AppTheme.greyText),
                ),
              ],
            ),
          ),
          CarDetailsCard(
            title: 'Lixiang L7 Pro',
            vinCode: 'HLX781788912311840',
            imagePath:
                'assets/images/lixiang_l7.png', // Путь к вашему изображению
            status: 'Доставлен',
            deliveryDate: '15.01.2025-16.01.2025',
            onButtonPressed: () {
              print('Нажата кнопка "Посмотреть"');
            },
          ),
        ],
      )),
    );
  }
}
