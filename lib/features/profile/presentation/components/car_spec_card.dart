import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';

class CarSpecsCard extends StatelessWidget {
  const CarSpecsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildSpecItem(
                title: 'Серый',
                subtitle: 'Цвет',
                titleStyle: AppTheme.displayMedium.copyWith(
                  color: AppTheme.black,
                ),
                subtitleStyle: AppTheme.bodyMedium500.copyWith(
                  color: AppTheme.greyText,
                ),
              ),
              SizedBox(
                width: 35.w,
              ),
              _buildSpecItem(
                title: '21″',
                subtitle: 'Диски',
                titleStyle: AppTheme.displayMedium.copyWith(
                  color: AppTheme.black,
                ),
                subtitleStyle: AppTheme.bodyMedium500.copyWith(
                  color: AppTheme.greyText,
                ),
              ),
              SizedBox(
                width: 35.w,
              ),
              _buildSpecItem(
                title: 'Новый',
                subtitle: 'Состояние',
                // цвет текста зелёный
                titleStyle: AppTheme.displayMedium.copyWith(
                  color: AppTheme.green,
                ),
                subtitleStyle: AppTheme.bodyMedium500.copyWith(
                  color: AppTheme.greyText,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),

          Row(
            children: [
              _buildSpecItem(
                title: 'ULTRA',
                subtitle: 'Комплектация',
                titleStyle: AppTheme.displayMedium.copyWith(
                  color: AppTheme.black,
                ),
                subtitleStyle: AppTheme.bodyMedium500.copyWith(
                  color: AppTheme.greyText,
                ),
              ),
              SizedBox(
                width: 35.w,
              ),
              _buildSalonItem(
                colors: const [
                  AppTheme.main,
                  AppTheme.orange
                ], // Цвета для «точек»
                label: 'Салон',
              ),
            ],
          ),
          // Блок с двумя цветными точками и подписью
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              _buildSpecItem(
                title: '2024',
                subtitle: 'Год производства',
                titleStyle: AppTheme.displayMedium.copyWith(
                  color: AppTheme.black,
                ),
                subtitleStyle: AppTheme.bodyMedium500.copyWith(
                  color: AppTheme.greyText,
                ),
              ),
              SizedBox(
                width: 35.w,
              ),
              _buildSpecItem(
                title: 'Краснодар',
                subtitle: 'Пункт доставки',
                titleStyle: AppTheme.displayMedium.copyWith(
                  color: AppTheme.black,
                ),
                subtitleStyle: AppTheme.bodyMedium500.copyWith(
                  color: AppTheme.greyText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Универсальный виджет для «большой текст + подзаголовок»
  Widget _buildSpecItem({
    required String title,
    required String subtitle,
    required TextStyle titleStyle,
    required TextStyle subtitleStyle,
  }) {
    return SizedBox(
      // можно подогнать под свой дизайн
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          Text(subtitle, style: subtitleStyle),
        ],
      ),
    );
  }

  /// Специальный виджет для «две точки + подпись»
  Widget _buildSalonItem({
    required List<Color> colors,
    required String label,
  }) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Две точки слева направо
          Row(
            children: colors.map((color) {
              return Container(
                width: 16.w,
                height: 16.w,
                margin: EdgeInsets.only(right: 4.w),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: AppTheme.bodyMedium500.copyWith(
              color: AppTheme.greyText,
            ),
          ),
        ],
      ),
    );
  }
}
