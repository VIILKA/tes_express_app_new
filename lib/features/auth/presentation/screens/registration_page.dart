import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tes_test_app/features/auth/presentation/blocs/auth_bloc.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

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

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _patronymicController.dispose();
    _phoneNumberController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    final name = _nameController.text.trim();
    final surname = _surnameController.text.trim();
    final patronymic = _patronymicController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();
    final login = _loginController.text.trim();
    final password = _passwordController.text.trim();

    // 2. Отправляем событие Register в BLoC
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          // 1. Если регистрация прошла успешно => AuthLoggedIn => переходим на '/'
          if (state is AuthLoggedIn) {
            context.go('/');
          }
          // 2. Если ошибка => показываем SnackBar
          if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            // Показать индикатор загрузки, пока ждём ответа
            return const Center(child: CircularProgressIndicator());
          }

          // Основная форма
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Имя'),
                ),
                TextField(
                  controller: _surnameController,
                  decoration: const InputDecoration(labelText: 'Фамилия'),
                ),
                TextField(
                  controller: _patronymicController,
                  decoration: const InputDecoration(labelText: 'Отчество'),
                ),
                TextField(
                  controller: _phoneNumberController,
                  decoration:
                      const InputDecoration(labelText: 'Номер телефона'),
                  keyboardType: TextInputType.phone,
                ),
                TextField(
                  controller: _loginController,
                  decoration: const InputDecoration(labelText: 'Логин'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Пароль'),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _onRegisterPressed,
                  child: const Text('Зарегистрироваться'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
