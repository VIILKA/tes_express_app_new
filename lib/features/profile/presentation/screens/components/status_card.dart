import 'package:flutter/material.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';

class StatusCard extends StatelessWidget {
  final int inTransit;
  final int atWarehouse;

  const StatusCard({
    Key? key,
    required this.inTransit,
    required this.atWarehouse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
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
          // Иконка и текст "Машин в пути"
          Row(
            children: [
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
                  Icons.local_shipping,
                  color: AppTheme.orange,
                  size: 30.0,
                ),
              ),
              const SizedBox(width: 16.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$inTransit',
                    style: AppTheme.displayMedium,
                  ),
                  Text(
                    'Машин в пути',
                    style:
                        AppTheme.bodyMedium.copyWith(color: AppTheme.greyText),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(width: 40.0),

          // Текст "На СВХ"
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$atWarehouse',
                style: AppTheme.displayMedium,
              ),
              Text(
                'На СВХ',
                style: AppTheme.bodyMedium.copyWith(color: AppTheme.greyText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
