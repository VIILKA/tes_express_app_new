import 'package:flutter/material.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';

class BlueButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isFullWidth;

  const BlueButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: Material(
        // <-- Добавляем Material
        color: Colors
            .transparent, // Прозрачная подложка, чтобы видеть нашу заливку внутри Ink
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30.0),
          splashColor: const Color.fromARGB(50, 255, 255, 255),
          highlightColor: const Color.fromARGB(50, 255, 255, 255),
          child: Ink(
            padding:
                const EdgeInsets.symmetric(vertical: 7.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: AppTheme.main,
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: isFullWidth
                ? Align(
                    alignment: Alignment.center,
                    child: Text(
                      text,
                      style: AppTheme.buttonText.copyWith(
                        color: AppTheme.whiteGrey,
                      ),
                    ),
                  )
                : Text(
                    text,
                    style: AppTheme.buttonText.copyWith(
                      color: AppTheme.whiteGrey,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
