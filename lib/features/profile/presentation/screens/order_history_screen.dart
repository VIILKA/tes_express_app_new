import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/features/logistic/presentation/components/car_details_card.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  // Тестовые данные для истории заказов
  final List<Map<String, String>> orderHistoryData = [
    {
      'title': 'Lixiang L7 Pro',
      'vinCode': 'HLX781788912311840',
      'imagePath': 'assets/images/lixiang_l7.png',
      'status': 'Доставлен',
      'deliveryDate': '15.01.2025-16.01.2025',
    },
    {
      'title': 'Zeekr 001 FR',
      'vinCode': 'ND78124612541219',
      'imagePath': 'assets/images/zeekr_001.png',
      'status': 'Доставлен',
      'deliveryDate': '10.12.2024-12.12.2024',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'История заказов',
          style: AppTheme.displayMedium,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'Ваши предыдущие заказы',
                  style:
                      AppTheme.bodyMedium500.copyWith(color: AppTheme.greyText),
                ),
              ),
              SizedBox(height: 16.h),
              // Список истории заказов
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: orderHistoryData.length,
                itemBuilder: (context, index) {
                  final order = orderHistoryData[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: CarDetailsCard(
                      title: order['title']!,
                      vinCode: order['vinCode']!,
                      imagePath: order['imagePath']!,
                      status: order['status']!,
                      deliveryDate: order['deliveryDate']!,
                      onButtonPressed: () {
                        // Здесь можно добавить навигацию на детальную страницу заказа, если нужно
                        print(
                            'Нажата кнопка "Посмотреть" для ${order['title']}');
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
