import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';

class StepCard extends StatelessWidget {
  final String title;
  final String description;
  final String startDate;
  final String endDate;

  /// Текст, который описывает причину/суть задержки. Если [delayMessage] не пустой, отобразится на экране.
  final String? delayMessage;

  /// Количество дней задержки. Если > 0, будет отображено красным цветом.
  final int? delayDays;

  const StepCard({
    super.key,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.delayMessage,
    this.delayDays,
  });

  @override
  Widget build(BuildContext context) {
    // Настраиваем тень и скругление
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Верхняя строка: зелёный кружок + заголовок + описание
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Кружок слева
              Container(
                width: 16.w,
                height: 16.w,
                margin: EdgeInsets.only(right: 8.w, top: 4.h),
                decoration: const BoxDecoration(
                  color: AppTheme.green,
                  shape: BoxShape.circle,
                ),
              ),
              // Текстовая часть (заголовок + подзаголовок)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Заголовок
                    Text(
                      title,
                      style: AppTheme.displaySmall.copyWith(
                        color: AppTheme.black,
                      ),
                    ),

                    // Подзаголовок
                    Text(
                      description,
                      style: AppTheme.bodyMedium500.copyWith(
                        color: AppTheme.greyText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Отступ между верхней и нижней частями

          // Дата начала - конца
          Row(
            children: [
              const Icon(
                Icons.access_time,
                color: AppTheme.orange,
                size: 16,
              ),
              SizedBox(width: 4.w),
              Text(
                '$startDate - $endDate',
                style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.orange, fontWeight: FontWeight.w600),
              ),
            ],
          ),

          // Если есть задержка — добавляем разделительную линию и информацию
          if ((delayMessage != null && delayMessage!.isNotEmpty) ||
              (delayDays != null && delayDays! > 0)) ...[
            // Разделительная линия
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Divider(
                color: AppTheme.grey.withOpacity(0.3),
                thickness: 1,
              ),
            ),
            // Сообщение о задержке (если есть)
            if (delayMessage != null && delayMessage!.isNotEmpty)
              Text(
                delayMessage!,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.greyText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            // Количество дней задержки (если есть)
            if (delayDays != null && delayDays! > 0)
              Padding(
                padding: EdgeInsets.only(top: 4.h),
                child: Text(
                  '$delayDays дня задержка',
                  style: AppTheme.bodySmall.copyWith(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
