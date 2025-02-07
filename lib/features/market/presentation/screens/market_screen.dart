import 'package:flutter/material.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';
import 'package:tes_test_app/features/market/presentation/screens/components/chapter_card.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Маркет',
                    style: AppTheme.displayLarge,
                  ),
                  Text(
                    'Сейчас мы едем до вашего пункта назначения,\nготовьтесь получать',
                    style:
                        AppTheme.bodySmall.copyWith(color: AppTheme.greyText),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              ChapterCard(
                title: 'Машины',

                imagePath:
                    'assets/images/cars.png', // Замените на путь к вашему изображению
                onButtonPressed: () {
                  print('Нажата кнопка "Подобрать"');
                },
              ),
              SizedBox(
                height: 15,
              ),
              ChapterCard(
                title: 'Запчасти',

                imagePath:
                    'assets/images/spare_cars.png', // Замените на путь к вашему изображению
                onButtonPressed: () {
                  print('Нажата кнопка "Подобрать"');
                },
              ),
              SizedBox(
                height: 15,
              ),
              ChapterCard(
                title: 'Акксессуары',

                imagePath:
                    'assets/images/accessories.png', // Замените на путь к вашему изображению
                onButtonPressed: () {
                  print('Нажата кнопка "Подобрать"');
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
