import 'package:flutter/material.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';
import 'package:tes_test_app/core/widgets/blue_button.dart';

class NewsCard extends StatelessWidget {
  final String imagePath;
  final String title;

  final VoidCallback onButtonPressed;

  const NewsCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3), // Затемняющий цвет с прозрачностью
            BlendMode.darken, // Режим наложения
          ),
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
              color: const Color.fromARGB(224, 97, 97, 97),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTheme.bodyMedium
                          .copyWith(color: AppTheme.whiteGrey),
                    ),
                  ],
                ),
                BlueButton(text: 'Перейти', onPressed: () {})
              ],
            ),
          ),
        ],
      ),
    );
  }
}
