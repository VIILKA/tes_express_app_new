import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/widgets/share_card.dart';
import 'package:tes_express_app_new/features/market/presentation/screens/components/car_specs_card.dart';
import 'package:tes_express_app_new/features/market/presentation/screens/components/price_card.dart';

class CarDetailsScreen extends StatelessWidget {
  final String carId;
  final String carName;
  final String? imageUrl;
  final String? price;
  final String description;

  const CarDetailsScreen({
    super.key,
    required this.carId,
    required this.carName,
    this.imageUrl,
    this.price,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => context.pop(),
                        ),
                        Text(
                          carName,
                          style: AppTheme.displayLarge,
                        ),
                      ],
                    ),
                    Text(
                      description,
                      style:
                          AppTheme.bodySmall.copyWith(color: AppTheme.greyText),
                    ),
                    if (imageUrl != null) ...[
                      SizedBox(height: 16.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.r),
                        child: Image.asset(
                          imageUrl!,
                          width: double.infinity,
                          height: 200.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              const CarSpecsCard(),
              SizedBox(height: 16.h),
              if (price != null)
                PriceCard(
                  price: price!,
                  onPressed: () {
                    // TODO: Implement price action
                  },
                ),
              SizedBox(height: 16.h),
              ShareCard(
                title: 'Поделиться',
                description: 'Поделитесь этим автомобилем с друзьями',
                onButtonPressed: () {
                  // TODO: Implement share action
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
