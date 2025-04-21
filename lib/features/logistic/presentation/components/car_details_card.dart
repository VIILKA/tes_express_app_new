import 'package:flutter/material.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/widgets/blue_button.dart';

class CarDetailsCard extends StatelessWidget {
  final String title;
  final String vinCode;
  final String imagePath;
  final String status;
  final String deliveryDate;
  final VoidCallback onButtonPressed;

  const CarDetailsCard({
    super.key,
    required this.title,
    required this.vinCode,
    required this.imagePath,
    required this.status,
    required this.deliveryDate,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 250,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.0,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Верхняя часть с названием и кнопкой
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.displayMedium,
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'VIN CODE: $vinCode',
                    style: AppTheme.bodyTiny.copyWith(
                      color: AppTheme.greyText,
                    ),
                  ),
                ],
              ),
              BlueButton(
                text: 'Посмотреть',
                onPressed: onButtonPressed,
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          // Изображение автомобиля
          Spacer(),
          const SizedBox(height: 16.0),
          // Статус и даты доставки
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.home,
                    color: AppTheme.green,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    status,
                    style: AppTheme.bodyTiny.copyWith(
                        color: AppTheme.green, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: AppTheme.green,
                  ),
                  const SizedBox(width: 4.0),
                  Text(
                    deliveryDate,
                    style:
                        AppTheme.bodyTiny.copyWith(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
