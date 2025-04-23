import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tes_express_app_new/core/routes/route_constants.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'components/chapter_card.dart';

class MarketPage extends StatelessWidget {
  const MarketPage({super.key});

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
                Text(
                  'Маркет',
                  style: AppTheme.displayLarge,
                ),
                Text(
                  'Выберите категорию',
                  style: AppTheme.bodySmall.copyWith(color: AppTheme.greyText),
                ),
                const SizedBox(height: 15),
                ChapterCard(
                  title: 'Машины',
                  imagePath: 'assets/images/cars.png',
                  onButtonPressed: () {
                    context.push(
                      '${RouteConstants.market}/${RouteConstants.cars}',
                    );
                  },
                ),
                const SizedBox(height: 15),
                ChapterCard(
                  title: 'Запчасти',
                  imagePath: 'assets/images/spare_cars.png',
                  buttonText: 'Скоро',
                  onButtonPressed: () {
                    print('Запчасти button pressed');
                  },
                ),
                const SizedBox(height: 15),
                ChapterCard(
                  title: 'Акксессуары',
                  imagePath: 'assets/images/accessories.png',
                  buttonText: 'Скоро',
                  onButtonPressed: () {
                    print('Акксессуары button pressed');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
