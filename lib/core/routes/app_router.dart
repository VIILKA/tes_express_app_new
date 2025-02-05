// app_router.dart

import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_test_app/core/routes/main_page.dart';
import 'package:tes_test_app/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:tes_test_app/features/auth/presentation/screens/login_page.dart';
import 'package:tes_test_app/features/auth/presentation/screens/registration_page.dart';
import 'package:tes_test_app/features/home/presentation/screens/home_screen.dart';
import 'package:tes_test_app/features/logistic/presentation/screens/logistic_screen.dart';
import 'package:tes_test_app/features/market/presentation/screens/market_screen.dart';
import 'package:tes_test_app/features/news/presentation/screens/news_screen.dart';
import 'package:tes_test_app/features/profile/presentation/screens/profile_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    // важный момент: чтобы go_router обновлялся при изменении AuthBloc,
    // можно подписать его на изменение состояния (через refreshListenable).
    // Для демонстрации логики пока оставим как есть.
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegistrationPage(),
      ),
      // Пример ShellRoute c MainPage:
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/market',
            builder: (context, state) => const MarketPage(),
          ),
          GoRoute(
            path: '/news',
            builder: (context, state) => const NewsPage(),
          ),
          GoRoute(
            path: '/logistic',
            builder: (context, state) => const LogisticPage(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      // Достаём текущий AuthState
      final authState = context.read<AuthBloc>().state;

      final isLoggingIn = state.uri.toString() == '/login' ||
          state.uri.toString() == '/register';

      // Если BLoC ещё грузится или в начальном состоянии — ничего не перенаправляем
      if (authState is AuthInitial || authState is AuthLoading) {
        return null;
      }

      // Если пользователь залогинен, а мы пытаемся на /login
      if (authState is AuthLoggedIn && isLoggingIn) {
        return '/home'; // перенаправляем на домашнюю страницу
      }

      // Если пользователь не залогинен, а мы пытаемся попасть куда-то, кроме /login|/register
      if (authState is AuthLoggedOut && !isLoggingIn) {
        return '/login';
      }

      // Иначе оставляем всё как есть
      return null;
    },
  );
}
