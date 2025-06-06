import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tes_express_app_new/core/routes/route_constants.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/features/auth/presentation/blocs/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _errorMessage;
  bool _hasLoginError = false;
  bool _hasPasswordError = false;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    final login = _loginController.text.trim();
    final password = _passwordController.text.trim();

    // Очищаем предыдущую ошибку при новой попытке входа
    setState(() {
      _errorMessage = null;
      _hasLoginError = false;
      _hasPasswordError = false;
    });

    // Валидация полей
    if (login.isEmpty) {
      setState(() {
        _hasLoginError = true;
      });
    }

    if (password.isEmpty) {
      setState(() {
        _hasPasswordError = true;
      });
    }

    // Если есть ошибки валидации, показываем сообщение и прерываем отправку
    if (_hasLoginError || _hasPasswordError) {
      setState(() {
        _errorMessage = 'Пожалуйста, заполните все поля';
      });
      return;
    }

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

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.error_outline, color: Colors.red),
              SizedBox(width: 10),
              Text('Ошибка авторизации'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Понятно'),
            ),
          ],
        );
      },
    );
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
            setState(() {
              _errorMessage = state.message;
            });

            // Показываем диалог с ошибкой для более наглядного отображения
            String errorMessage = state.message;

            // Если ошибка 404, показываем более понятное сообщение
            if (errorMessage.contains('404')) {
              errorMessage =
                  'Сервер не отвечает или адрес сервиса входа недоступен. Пожалуйста, попробуйте позже.';
            }

            _showErrorDialog(errorMessage);
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
                      if (_errorMessage != null) ...[
                        SizedBox(height: 10.h),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red.shade200),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.error_outline,
                                  color: Colors.red, size: 20),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  _errorMessage!,
                                  style: TextStyle(color: Colors.red.shade700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: 23.h),
                      _buildLoginButton(),
                      SizedBox(height: 12.h),
                      _buildRegisterLink(),
                      SizedBox(height: 12.h),
                      // Кнопка "Продолжить как гость"
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(ContinueAsGuest());
                          },
                          child: Text(
                            'Продолжить как гость',
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.greyText,
                            ),
                          ),
                        ),
                      ),
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
    // Определяем, есть ли ошибка для данного поля
    bool hasError = false;
    if (controller == _loginController && _hasLoginError) {
      hasError = true;
    } else if (controller == _passwordController && _hasPasswordError) {
      hasError = true;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.bodyLarge.copyWith(
            color: hasError ? Colors.red : AppTheme.black,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          height: 44.h,
          decoration: BoxDecoration(
            color: AppTheme.whiteGrey,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: hasError ? Colors.red : AppTheme.greyText,
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
              onChanged: (_) {
                // Сбрасываем ошибку при вводе текста
                if (hasError) {
                  setState(() {
                    if (controller == _loginController) {
                      _hasLoginError = false;
                    } else if (controller == _passwordController) {
                      _hasPasswordError = false;
                    }

                    // Если все поля заполнены, убираем общее сообщение об ошибке
                    if (!_hasLoginError && !_hasPasswordError) {
                      _errorMessage = null;
                    }
                  });
                }
              },
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
