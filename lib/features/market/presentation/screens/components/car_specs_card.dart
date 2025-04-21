import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';

class CarSpecsCard extends StatelessWidget {
  const CarSpecsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSpecItem('Серый', 'Цвет'),
              _buildSpecItem('21"', 'Диски'),
              _buildSpecItem('Новый', 'Состояние'),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildSpecItem('ULTRA', 'Комплектация'),
              Row(
                children: [
                  Container(
                    width: 18.w,
                    height: 18.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF00FFE1),
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Container(
                    width: 18.w,
                    height: 18.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF7E3DFF),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Салон',
                    style:
                        AppTheme.bodySmall.copyWith(color: AppTheme.greyText),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          _buildSpecItem('2024', 'Год производства'),
        ],
      ),
    );
  }

  Widget _buildSpecItem(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: AppTheme.displayMedium,
        ),
        Text(
          label,
          style: AppTheme.bodySmall.copyWith(color: AppTheme.greyText),
        ),
      ],
    );
  }
}
