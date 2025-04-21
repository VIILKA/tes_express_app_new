import 'package:flutter/material.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/widgets/blue_button.dart';

class StatusesCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onButtonPressed;
  const StatusesCard(
      {super.key,
      required this.title,
      required this.description,
      required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                  description,
                  style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.greyText, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 16.0),
                BlueButton(
                  text: 'Посмотреть',
                  onPressed: onButtonPressed,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
          // Иконка
          Image.asset(
            'assets/images/setting_icon.png',
            width: 35,
          ),
        ],
      ),
    );
  }
}
