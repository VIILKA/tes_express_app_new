// feature/auth/presentation/pages/registration_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_test_app/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:go_router/go_router.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();
    final phoneNumber = _phoneNumberController.text.trim();
    final login = _loginController.text.trim();
    final password = _passwordController.text.trim();

    context.read<AuthBloc>().add(Register(
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          login: login,
          password: password,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Регистрация'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedIn) {
            // Если после регистрации мы автоматически залогинились
            context.go('/');
          }
          if (state is AuthError) {
            // Показываем ошибку
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: const InputDecoration(labelText: 'Имя'),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: const InputDecoration(labelText: 'Фамилия'),
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
