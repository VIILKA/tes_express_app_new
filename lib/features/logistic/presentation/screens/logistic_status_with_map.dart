import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/widgets/circular_avatar.dart';
import 'package:tes_express_app_new/core/widgets/share_card.dart';
import 'package:tes_express_app_new/core/widgets/steps_card.dart';
import 'package:tes_express_app_new/features/logistic/presentation/components/map_with_marker.dart';

class LogisticStatusWithMap extends StatefulWidget {
  const LogisticStatusWithMap({super.key});

  @override
  State<LogisticStatusWithMap> createState() => _LogisticStatusWithMapState();
}

class _LogisticStatusWithMapState extends State<LogisticStatusWithMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Логистика',
                        style: AppTheme.displayLarge,
                      ),
                      CircularAvatar(
                          imageUrl: 'assets/images/avatar_cat.png',
                          size: 30.0,
                          borderWidth: 0.0,
                          borderColor: AppTheme.black),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lixiang L7 Pro',
                            style: AppTheme.displayMedium,
                          ),
                          Text(
                            'VIN CODE: HLX8787234',
                            style: AppTheme.bodySmall
                                .copyWith(color: AppTheme.greyText),
                          ),
                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Image.asset(
                          'assets/images/lixiang_l7.png',
                          width: 90.w,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            MapWithMarker(
              latitude: 44.41637,
              longitude: 84.89814,
            ),
            Column(
              children: [
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
            ),
            ShareCard(
              title: 'Поделиться',
              description:
                  'Сейчас мы едем до вашего пункта назначения, готовьтесь получать',
              onButtonPressed: () {
                print('Кнопка "Посмотреть" нажата');
              },
            ),
            SizedBox(
              height: 12.h,
            )
          ],
        ),
      )),
    );
  }
}
