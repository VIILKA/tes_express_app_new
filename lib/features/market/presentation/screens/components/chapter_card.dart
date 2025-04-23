import 'package:flutter/material.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/widgets/blue_button.dart';

class ChapterCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onButtonPressed;
  final String buttonText;

  const ChapterCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onButtonPressed,
    this.buttonText = 'Посмотреть',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      // Сделаем так, чтобы контейнер занял всю доступную ширину:
      width: double.infinity,
      // Фиксируем высоту, например 250. Или можно задать динамически.
      height: 210,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover, // ключевой параметр для "заливки" всего контейнера
        ),
      ),
      // Если вам нужно контент (текст, кнопки) — добавляйте child:
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.displayMedium,
          ),
          Spacer(),
          BlueButton(text: buttonText, onPressed: onButtonPressed)
        ],
      ),
    );
  }
}
