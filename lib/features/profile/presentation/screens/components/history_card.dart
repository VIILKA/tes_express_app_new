import 'package:flutter/material.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';
import 'package:tes_test_app/core/widgets/blue_button.dart';

class HistoryCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onButtonPressed;

  const HistoryCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onButtonPressed,
  }) : super(key: key);

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
                  style: AppTheme.bodyMedium.copyWith(
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
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.orange,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: const Icon(
              Icons.list_alt, // Иконка "список"
              color: Colors.white,
              size: 28.0,
            ),
          ),
        ],
      ),
    );
  }
}
