import 'package:flutter/material.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/widgets/blue_button.dart';

class CarSelectionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imagePath;
  final VoidCallback onButtonPressed;

  const CarSelectionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      margin: EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage(
              'assets/images/zeekr_on_white.jpeg'), // Замените на путь к изображению
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Текстовая часть
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTheme.displayMedium,
                ),
                Text(
                  subtitle,
                  style: AppTheme.bodySmall.copyWith(color: AppTheme.greyText),
                ),
                Spacer(),
                BlueButton(text: 'Подобрать', onPressed: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
