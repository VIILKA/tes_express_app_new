import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tes_test_app/core/routes/route_constants.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_test_app/features/auth/presentation/blocs/auth_bloc.dart';

class NotRegisteredUserPage extends StatefulWidget {
  const NotRegisteredUserPage({super.key});

  @override
  State<NotRegisteredUserPage> createState() => _NotRegisteredUserPageState();
}

class _NotRegisteredUserPageState extends State<NotRegisteredUserPage> {
  void _onLoginTap() {
    context.read<AuthBloc>().add(Logout());
    context.go(RouteConstants.login);
  }

  void _onRegisterTap() {
    context.read<AuthBloc>().add(Logout());
    context.go(RouteConstants.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Профиль',
                      style: AppTheme.displayLarge,
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(15.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8F8F8),
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
                          // Иконка профиля
                          Container(
                            width: 41.w,
                            height: 40.h,
                            decoration: const BoxDecoration(
                              color: Color(0xFFDEB236), // RGB(221, 178, 54)
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          // Текстовый блок
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Создать/войти в аккаунт',
                                style: AppTheme.displayMedium.copyWith(
                                  color: const Color(0xFF0F0F0F),
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Для получения доступа ко всем функциям и быть в курсе всех новых событий',
                                style: AppTheme.bodySmall.copyWith(
                                  color: const Color(0xFF8E8E93),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          // Кнопки
                          Row(
                            children: [
                              GestureDetector(
                                onTap: _onLoginTap,
                                child: Container(
                                  height: 28.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF007AFF),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Войти',
                                      style: AppTheme.bodySmall.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              GestureDetector(
                                onTap: _onRegisterTap,
                                child: Container(
                                  height: 28.h,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xFF8E8E93),
                                    ),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Зарегистрироваться',
                                      style: AppTheme.bodySmall.copyWith(
                                        color: const Color(0xFF8E8E93),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
