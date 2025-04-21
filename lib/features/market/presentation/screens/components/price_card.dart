import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/widgets/blue_button.dart';

class PriceCard extends StatelessWidget {
  final String price;
  final VoidCallback onPressed;

  const PriceCard({
    super.key,
    required this.price,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 24,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.black.withAlpha(20),
            blurRadius: 2,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            price,
            style: AppTheme.displayLarge,
          ),
          SizedBox(height: 5.h),
          Text(
            'Сейчас мы едем до вашего пункта назначения, готовьтесь получать',
            style: AppTheme.bodySmall.copyWith(color: AppTheme.greyText),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BlueButton(
                text: 'Стоимость',
                onPressed: onPressed,
              ),
              Container(
                width: 70.w,
                height: 50.h,
                decoration: const BoxDecoration(
                  color: Color(0xFFDEB237),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
