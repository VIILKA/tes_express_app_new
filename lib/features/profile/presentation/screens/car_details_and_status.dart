import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/widgets/share_card.dart';
import 'package:tes_express_app_new/core/widgets/statuses_card.dart';
import 'package:tes_express_app_new/features/profile/presentation/components/car_spec_card.dart';
import 'package:tes_express_app_new/features/profile/presentation/components/logistics_card.dart';

class CarDetailsAndStatus extends StatelessWidget {
  final String title;
  final String vinCode;
  final String imagePath;

  const CarDetailsAndStatus({
    super.key,
    required this.title,
    required this.vinCode,
    required this.imagePath,
  });

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
                    title,
                    style: AppTheme.displayLarge,
                  ),
                  Text(
                    'VIN CODE: $vinCode',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.greyText,
                    ),
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(imagePath)),
                ],
              ),
            ),
            CarSpecsCard(),
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
                _shareCarDetails();
              },
            ),
          ],
        ),
      )),
    );
  }

  void _shareCarDetails() {
    final String shareText =
        'Автомобиль: $title\nVIN код: $vinCode\nПроверьте этот автомобиль в приложении TES Express!';

    final params = ShareParams(
      text: shareText,
      subject: 'Информация об автомобиле $title',
    );

    SharePlus.instance.share(params);
  }
}
