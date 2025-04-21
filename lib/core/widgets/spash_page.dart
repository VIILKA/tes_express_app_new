import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tes_express_app_new/core/routes/route_constants.dart';
import 'package:tes_express_app_new/features/auth/presentation/blocs/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    // Add a small delay to show the splash screen
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;

    final authBloc = context.read<AuthBloc>();
    authBloc.add(CheckAuth());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listenWhen: (previous, current) =>
            current is AuthLoggedIn ||
            current is AuthGuest ||
            current is AuthLoggedOut,
        listener: (context, state) {
          if (state is AuthLoggedIn) {
            context.go(RouteConstants.home); // теперь '/home'
          } else if (state is AuthGuest) {
            context.go(RouteConstants.home); // тоже '/home'
          } else if (state is AuthLoggedOut) {
            context.go(RouteConstants.login); // '/login'
          }
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
