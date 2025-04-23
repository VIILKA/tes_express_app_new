import 'package:flutter/material.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/widgets/blue_button.dart';

class CarCardWidget extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final VoidCallback onButtonPressed;

  const CarCardWidget({
    super.key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.onButtonPressed,
  });

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
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
              color: const Color.fromARGB(224, 97, 97, 97),
            ),
            child: Row(
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
                    Text(
                      price,
                      style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.grey, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
