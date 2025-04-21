import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/widgets/share_card.dart';
import 'package:tes_express_app_new/core/widgets/statuses_card.dart';
import 'package:tes_express_app_new/features/profile/presentation/components/car_spec_card.dart';
import 'package:tes_express_app_new/features/profile/presentation/components/logistics_card.dart';

class CarDetailsAndStatus extends StatelessWidget {
  const CarDetailsAndStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lixiang L7 Pro',
                    style: AppTheme.displayLarge,
                  ),
                  Text(
                    'VIN CODE: HLX781788912311840',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.greyText,
                    ),
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/images/lixiang_l7.png')),
                ],
              ),
            ),
            CarSpecsCard(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: LogisticsCard(
                title: 'Логистика',
                buttonText: 'Посмотреть',
                onButtonPressed: () {
                  print('Кнопка "Посмотреть" нажата');
                },
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            StatusesCard(
                title: "Записи",
                description:
                    'Сейчас мы едем до вашего пункта назначения, готовьтесь получать',
                onButtonPressed: () {
                  context.go('/profile/car_details_status/steps_statuses');
                }),
            SizedBox(
              height: 15.h,
            ),
            ShareCard(
              title: 'Поделиться',
              description:
                  'Сейчас мы едем до вашего пункта назначения, готовьтесь получать',
              onButtonPressed: () {
                print('Кнопка "Посмотреть" нажата');
              },
            ),
          ],
        ),
      )),
    );
  }
}
