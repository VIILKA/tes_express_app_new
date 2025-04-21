import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/widgets/blue_button.dart';

class CarCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String color;
  final String bodyType;
  final VoidCallback onViewPressed;

  const CarCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.bodyType,
    required this.onViewPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 24,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.displayMedium,
          ),
          SizedBox(height: 4.h),
          Text(
            subtitle,
            style: AppTheme.bodySmall.copyWith(color: AppTheme.greyText),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              _buildInfoChip(color),
              SizedBox(width: 8.w),
              _buildInfoChip(bodyType),
            ],
          ),
          SizedBox(height: 16.h),
          BlueButton(
            text: 'Посмотреть',
            onPressed: onViewPressed,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppTheme.main.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: AppTheme.bodySmall.copyWith(color: AppTheme.main),
      ),
    );
  }
}
