import 'package:flutter/material.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';
import 'package:tes_test_app/core/widgets/blue_button.dart';

class ChapterCard extends StatelessWidget {
  final String title;

  final String imagePath;
  final VoidCallback onButtonPressed;

  const ChapterCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onButtonPressed,
  }) : super(key: key);

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
            color: Colors.black.withOpacity(0.1),
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
          BlueButton(text: 'Посмотреть', onPressed: () {})
        ],
      ),
    );
  }
}
