import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static TextStyle displayLarge = TextStyle(
    fontSize: 27.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle displayMedium = TextStyle(
    fontSize: 21.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle displaySmall = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bodyLarge = TextStyle(
    fontSize: 17.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bodyMedium500 = TextStyle(
    fontSize: 15.sp,
    fontWeight: FontWeight.w500,
  );
  static TextStyle buttonText = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyTiny = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
  );

  static const Color main = Color.fromRGBO(0, 123, 255, 1);
  static const Color orange = Color(0xffDEB236);
  static const Color grey = Color.fromRGBO(153, 162, 173, 0.88);
  static const Color green = Color(0xFF43C432);
  static const Color black = Color(0xFF000000);
  static const Color whiteGrey = Color.fromARGB(244, 248, 248, 248);
  static const Color greyText = Color.fromRGBO(142, 142, 147, 0.95);
}
