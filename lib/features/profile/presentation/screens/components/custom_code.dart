import 'package:flutter/material.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';

class CustomCodeWidget extends StatelessWidget {
  final String code;
  final String description;

  const CustomCodeWidget({
    Key? key,
    required this.code,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Иконка
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppTheme.orange, // Оранжевые границы
                width: 4.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Icon(
              Icons.person_outline, // Иконка
              color: AppTheme.orange,
              size: 30.0,
            ),
          ),
          const SizedBox(width: 16.0),
          // Текст
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                code,
                style: AppTheme.displayMedium,
              ),
              Text(
                description,
                style: AppTheme.bodyMedium.copyWith(color: AppTheme.greyText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
