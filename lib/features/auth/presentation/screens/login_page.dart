import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tes_test_app/core/routes/route_constants.dart';
import 'package:tes_test_app/core/styles/app_theme.dart';
import 'package:tes_test_app/features/auth/presentation/blocs/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final login = _loginController.text.trim();
    final password = _passwordController.text.trim();

    // Проверка на админский доступ
    if (login == 'admin' && password == 'admin') {
      context.read<AuthBloc>().add(Login(login, password));
    } else {
      context.read<AuthBloc>().add(Login(login, password));
    }
  }

  void _onRegisterTap() {
    context.go(RouteConstants.register);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedIn) {
            context.go(RouteConstants.home);
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 72.h),
                      Text(
                        'Вход',
                        style: AppTheme.displayLarge.copyWith(
                          color: AppTheme.black,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Введите данные для входа',
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.greyText,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      _buildInputField(
                        label: 'Логин',
                        controller: _loginController,
                      ),
                      SizedBox(height: 15.h),
                      _buildInputField(
                        label: 'Пароль',
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      SizedBox(height: 23.h),
                      _buildLoginButton(),
                      SizedBox(height: 12.h),
                      _buildRegisterLink(),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Container(
                  width: double.infinity,
                  height: 180.h,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/auth_half_car.png'),
                      fit: BoxFit.contain,
                      alignment: Alignment
                          .centerLeft, // Прижимаем изображение к левому краю
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.bodyLarge.copyWith(
            color: AppTheme.black,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          height: 44.h,
          decoration: BoxDecoration(
            color: AppTheme.whiteGrey,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.greyText,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 2,
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.08),
                blurRadius: 24,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: TextField(
              controller: controller,
              obscureText: obscureText,
              style: AppTheme.bodyMedium,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                border: InputBorder.none,
                hintStyle: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.greyText,
                ),
                isDense: true,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: CupertinoButton(
        onPressed: _onLoginPressed,
        color: AppTheme.main,
        borderRadius: BorderRadius.circular(40),
        child: Text(
          'Продолжить',
          style: AppTheme.bodyMedium.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterLink() {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: TextButton(
        onPressed: _onRegisterTap,
        child: Text(
          'Нет аккаунта? Зарегистрироваться',
          style: AppTheme.buttonText.copyWith(
            color: AppTheme.greyText,
          ),
        ),
      ),
    );
  }
}
