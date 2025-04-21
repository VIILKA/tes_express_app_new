import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';

class DeliveryCard extends StatelessWidget {
  const DeliveryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Доставка',
            style: AppTheme.displayMedium,
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDeliveryItem('Срок', '2-3 недели'),
              _buildDeliveryItem('Стоимость', 'Бесплатно'),
              _buildDeliveryItem('Страна', 'Китай'),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDeliveryItem('Порт', 'Владивосток'),
              _buildDeliveryItem('Статус', 'В пути'),
              _buildDeliveryItem('Дата', '15.03.2024'),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDeliveryItem('Трек', 'CN123456789'),
              _buildDeliveryItem('Компания', 'Zeekr'),
              _buildDeliveryItem('Тип', 'Морская'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTheme.displaySmall,
        ),
        Text(
          label,
          style: AppTheme.bodySmall.copyWith(color: AppTheme.greyText),
        ),
      ],
    );
  }
}
