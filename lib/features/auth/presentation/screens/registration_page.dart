import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tes_express_app_new/core/styles/app_theme.dart';
import 'package:tes_express_app_new/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:tes_express_app_new/core/routes/route_constants.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // 1. Контроллеры для полей
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _patronymicController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  // Для отображения общей ошибки от сервера
  String? _serverErrorMessage;

  // Добавляем контроллеры для отслеживания ошибок
  final Map<String, String?> _errors = {
    'name': null,
    'surname': null,
    'patronymic': null,
    'phoneNumber': null,
    'login': null,
    'password': null,
  };

  // Добавляем FocusNode для каждого поля
  final _nameFocus = FocusNode();
  final _surnameFocus = FocusNode();
  final _patronymicFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _loginFocus = FocusNode();
  final _passwordFocus = FocusNode();

  // Регулярные выражения для валидации
  final RegExp _nameRegExp = RegExp(r'^[a-zA-Zа-яА-ЯёЁ]+$');
  final RegExp _phoneRegExp = RegExp(r'^[0-9]{5,15}$');
  final RegExp _loginRegExp = RegExp(r'^[a-zA-Zа-яА-ЯёЁ0-9_]{3,35}$');
  final RegExp _passwordRegExp = RegExp(r'^.{6,}$');

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _patronymicController.dispose();
    _phoneNumberController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    _nameFocus.dispose();
    _surnameFocus.dispose();
    _patronymicFocus.dispose();
    _phoneFocus.dispose();
    _loginFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  // Валидация имени, фамилии, отчества (только буквы)
  String? _validateName(String value, String fieldName) {
    if (value.isEmpty) {
      return 'Поле обязательно для заполнения';
    }
    if (!_nameRegExp.hasMatch(value)) {
      return 'Используйте только буквы';
    }
    return null;
  }

  // Валидация номера телефона
  String? _validatePhone(String value) {
    if (value.isEmpty) {
      return 'Введите номер телефона';
    }
    if (!_phoneRegExp.hasMatch(value)) {
      return 'Неверный формат номера';
    }
    return null;
  }

  // Валидация логина
  String? _validateLogin(String value) {
    if (value.isEmpty) {
      return 'Введите логин';
    }
    if (!_loginRegExp.hasMatch(value)) {
      return 'Логин должен содержать от 3 до 35 символов';
    }
    return null;
  }

  // Валидация пароля
  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Введите пароль';
    }
    if (!_passwordRegExp.hasMatch(value)) {
      return 'Минимум 6 символов';
    }
    return null;
  }

  void _onRegisterPressed() {
    // Сбрасываем ошибку сервера при новой попытке
    setState(() {
      _serverErrorMessage = null;
    });

    // Валидация всех полей
    final name = _nameController.text.trim();
    final surname = _surnameController.text.trim();
    final patronymic = _patronymicController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();
    final login = _loginController.text.trim();
    final password = _passwordController.text.trim();

    // Обновляем состояние ошибок
    setState(() {
      _errors['name'] = _validateName(name, 'имя');
      _errors['surname'] = _validateName(surname, 'фамилия');
      _errors['patronymic'] = _validateName(patronymic, 'отчество');
      _errors['phoneNumber'] = _validatePhone(phoneNumber);
      _errors['login'] = _validateLogin(login);
      _errors['password'] = _validatePassword(password);
    });

    // Проверяем наличие ошибок
    if (_errors.values.every((error) => error == null)) {
      // Если ошибок нет, отправляем событие регистрации
      context.read<AuthBloc>().add(
            Register(
              name: name,
              surname: surname,
              patronymic: patronymic,
              phoneNumber: phoneNumber,
              login: login,
              password: password,
            ),
          );
    }
  }

  // Обновленная навигация на страницу входа
  void _onLoginTap() {
    context.go(RouteConstants.login);
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
              Text('Ошибка регистрации'),
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
          if (state is AuthLoggedIn || state is AuthGuest) {
            context.go(RouteConstants.home);
          }
          if (state is AuthError) {
            setState(() {
              _serverErrorMessage = state.message;
            });
            _showErrorDialog(state.message);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 72.h),
                  Text(
                    'Регистрация',
                    style: AppTheme.displayLarge.copyWith(
                      color: AppTheme.black,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Заполните данные для регистрации',
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.greyText,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Общее сообщение об ошибке от сервера
                  if (_serverErrorMessage != null) ...[
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
                              _serverErrorMessage!,
                              style: TextStyle(color: Colors.red.shade700),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],

                  _buildInputField(
                    label: 'Имя',
                    controller: _nameController,
                    fieldKey: 'name',
                    focusNode: _nameFocus,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 15.h),
                  _buildInputField(
                    label: 'Фамилия',
                    controller: _surnameController,
                    fieldKey: 'surname',
                    focusNode: _surnameFocus,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 15.h),
                  _buildInputField(
                    label: 'Отчество',
                    controller: _patronymicController,
                    fieldKey: 'patronymic',
                    focusNode: _patronymicFocus,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 15.h),
                  _buildInputField(
                    label: 'Номер телефона',
                    controller: _phoneNumberController,
                    fieldKey: 'phoneNumber',
                    focusNode: _phoneFocus,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                  SizedBox(height: 15.h),
                  _buildInputField(
                    label: 'Логин',
                    controller: _loginController,
                    fieldKey: 'login',
                    focusNode: _loginFocus,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 15.h),
                  _buildInputField(
                    label: 'Пароль',
                    controller: _passwordController,
                    fieldKey: 'password',
                    focusNode: _passwordFocus,
                    obscureText: true,
                  ),
                  SizedBox(height: 23.h),
                  _buildRegisterButton(),
                  SizedBox(height: 12.h),
                  _buildLoginLink(),
                  _buildContinueAsGuestButton(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String fieldKey,
    required FocusNode focusNode,
    TextInputType? keyboardType,
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.bodyMedium.copyWith(
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
              color: _errors[fieldKey] != null ? Colors.red : AppTheme.greyText,
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
              focusNode: focusNode,
              keyboardType: keyboardType,
              obscureText: obscureText,
              style: AppTheme.bodyMedium.copyWith(fontWeight: FontWeight.w400),
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                border: InputBorder.none,
                hintStyle: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.greyText,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  switch (fieldKey) {
                    case 'name':
                    case 'surname':
                    case 'patronymic':
                      _errors[fieldKey] = _validateName(value.trim(), label);
                      break;
                    case 'phoneNumber':
                      _errors[fieldKey] = _validatePhone(value.trim());
                      break;
                    case 'login':
                      _errors[fieldKey] = _validateLogin(value.trim());
                      break;
                    case 'password':
                      _errors[fieldKey] = _validatePassword(value.trim());
                      break;
                  }
                });
              },
              inputFormatters: inputFormatters,
            ),
          ),
        ),
        if (_errors[fieldKey] != null)
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 15.w),
            child: Text(
              _errors[fieldKey]!,
              style: AppTheme.bodyTiny.copyWith(
                color: Colors.red,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      height: 54.h,
      child: CupertinoButton(
        onPressed: _onRegisterPressed,
        color: AppTheme.main,
        borderRadius: BorderRadius.circular(40),
        padding: EdgeInsets.zero,
        child: Text(
          'Продолжить',
          style: AppTheme.bodyMedium.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return SizedBox(
      width: double.infinity,
      height: 44.h,
      child: TextButton(
        onPressed: _onLoginTap,
        child: Text(
          'Уже есть аккаунт? Войти',
          style: AppTheme.buttonText.copyWith(
            color: AppTheme.greyText,
          ),
        ),
      ),
    );
  }

  Widget _buildContinueAsGuestButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          context.read<AuthBloc>().add(ContinueAsGuest());
        },
        child: Text(
          'Продолжить без регистрации',
          style: AppTheme.buttonText.copyWith(
            color: AppTheme.greyText,
          ),
        ),
      ),
    );
  }
}
