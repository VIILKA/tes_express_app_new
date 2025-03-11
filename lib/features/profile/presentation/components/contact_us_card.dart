import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsCard extends StatelessWidget {
  // Номер телефона для WhatsApp
  static const String phoneNumber = '996990090030'; // Замените на нужный номер

  const ContactUsCard({super.key});

  Future<void> _launchWhatsApp() async {
    // Создаем URL для WhatsApp с номером телефона
    final Uri whatsappUrl = Uri.parse('https://wa.me/$phoneNumber');

    if (!await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication)) {
      throw Exception('Не удалось открыть WhatsApp');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8).withOpacity(0.95),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Зеленая иконка
          Container(
            width: 41.w,
            height: 40.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/whatsapp_icon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          // Текстовый блок
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Свяжитесь с нами',
                style: AppTheme.displayMedium.copyWith(
                  color: const Color(0xFF0F0F0F).withOpacity(0.95),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Для получения доступа ко всем функциям и быть в курсе всех новых событий',
                style: AppTheme.bodySmall.copyWith(
                  color: const Color(0xFF8E8E93).withOpacity(0.95),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          // Кнопка
          GestureDetector(
            onTap: _launchWhatsApp,
            child: Container(
              height: 28.h,
              width: 105.w,
              decoration: BoxDecoration(
                color: const Color(0xFF007AFF),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Center(
                child: Text(
                  'Написать',
                  style: AppTheme.bodySmall.copyWith(
                    color: const Color(0xFFF8F8F8).withOpacity(0.95),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
