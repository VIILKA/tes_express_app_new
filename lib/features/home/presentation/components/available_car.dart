import 'package:flutter/material.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/core/widgets/blue_button.dart';

class AvailableCar extends StatelessWidget {
  final VoidCallback onButtonPressed;

  const AvailableCar({super.key, required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        image: const DecorationImage(
          image: AssetImage(
              'assets/images/availible_car.jpeg'), // Замените на путь к изображению
          fit: BoxFit.cover,
        ),
        // Прозрачный слой внутри контейнера
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.black.withOpacity(0.4),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Машины в наличии!',
                style:
                    AppTheme.displayMedium.copyWith(color: AppTheme.whiteGrey)),
            const Text(
              'У нас в наличии большой выбор автомобилей\nв России, готовых к быстрой доставке!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            BlueButton(
              text: 'Подробнее',
              onPressed: onButtonPressed,
              isFullWidth: false,
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                InfoRow(
                  icon: Icons.handshake,
                  text: 'Сопровождаем на каждом этапе покупки',
                ),
                SizedBox(height: 8.0),
                InfoRow(
                  icon: Icons.check_circle_outline,
                  text: 'Подберем оптимальный вариант',
                ),
                SizedBox(height: 8.0),
                InfoRow(
                  icon: Icons.map_outlined,
                  text: 'Предложим выгодные условия покупки',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.green, size: 20.0),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
