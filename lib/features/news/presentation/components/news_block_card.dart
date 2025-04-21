import 'package:flutter/material.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';

class NewsBlockCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;
  final String description;

  final VoidCallback onButtonPressed;

  const NewsBlockCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.onButtonPressed,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Stack(
        children: [
          // Само изображение фоном
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 220, // Подберите нужную высоту
          ),
          // Тёмный градиент от прозрачного к насыщенному чёрному
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.0),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
          // Содержимое внизу
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Верхняя строка: "Frame" слева, иконка + дата справа
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: AppTheme.whiteGrey,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          date,
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.whiteGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                // Заголовок
                Text(
                  title,
                  style: AppTheme.displaySmall.copyWith(
                    color: Colors.white,
                  ),
                ),

                // Описание
                Text(
                  description,
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.whiteGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
