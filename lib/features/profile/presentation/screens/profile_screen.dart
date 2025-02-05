import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes_test_app/features/auth/presentation/blocs/auth_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoggedOut) {
            // Если после логаута состояние AuthLoggedOut,
            // перенаправляем пользователя на /login
            context.go('/login');
          }
        },
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              // При нажатии вызываем событие Logout
              context.read<AuthBloc>().add(Logout());
            },
            child: const Text('Выйти из аккаунта'),
          ),
        ),
      ),
    );
  }
}
