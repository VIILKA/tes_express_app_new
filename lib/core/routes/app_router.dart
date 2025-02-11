import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tes_test_app/core/routes/main_page.dart';
import 'package:tes_test_app/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:tes_test_app/features/auth/presentation/screens/login_page.dart';
import 'package:tes_test_app/features/auth/presentation/screens/registration_page.dart';
import 'package:tes_test_app/features/home/presentation/screens/home_screen.dart';
import 'package:tes_test_app/features/logistic/presentation/screens/logistic_screen.dart';
import 'package:tes_test_app/features/logistic/presentation/screens/logistic_status_with_map.dart';
import 'package:tes_test_app/features/market/presentation/screens/market_screen.dart';
import 'package:tes_test_app/features/news/presentation/screens/news_screen.dart';
import 'package:tes_test_app/features/profile/presentation/screens/car_details_and_status.dart';
import 'package:tes_test_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:tes_test_app/features/profile/presentation/screens/statuses_steps.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      // ---------- Экран Login с анимацией ----------
      GoRoute(
        path: '/login',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const LoginPage(),
            transitionDuration: const Duration(milliseconds: 100),
            reverseTransitionDuration: const Duration(milliseconds: 100),
            transitionsBuilder: _fadeTransition, // Или любую другую анимацию
          );
        },
      ),

      // ---------- Экран Register с анимацией ----------
      GoRoute(
        path: '/register',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const RegistrationPage(),
            transitionDuration: const Duration(milliseconds: 100),
            reverseTransitionDuration: const Duration(milliseconds: 100),
            transitionsBuilder: _fadeTransition,
          );
        },
      ),

      // ---------- ShellRoute с анимацией ----------
      // Вариант: анимируется сам shell. Т.е. при переходах между /home, /market и т.д.
      // будет тоже применяться анимация.
      // Если хотите анимацию только внутри этих вложенных GoRoute —
      // можно убрать pageBuilder из ShellRoute и перенести в каждый GoRoute.
      ShellRoute(
        pageBuilder: (context, state, child) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: MainPage(child: child),
            transitionDuration: const Duration(milliseconds: 100),
            reverseTransitionDuration: const Duration(milliseconds: 100),
            // Пример анимации — слайд слева направо. Можно заменить на fade.
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final begin = const Offset(1.0, 0.0);
              final end = Offset.zero;
              final curve = Curves.easeInOut;

              final tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve),
              );

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          );
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const HomePage(),
                transitionDuration: const Duration(milliseconds: 100),
                reverseTransitionDuration: const Duration(milliseconds: 100),
                transitionsBuilder: _fadeTransition,
              );
            },
          ),
          GoRoute(
            path: '/market',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const MarketPage(),
                transitionDuration: const Duration(milliseconds: 100),
                reverseTransitionDuration: const Duration(milliseconds: 100),
                transitionsBuilder: _fadeTransition,
              );
            },
          ),
          GoRoute(
            path: '/news',
            pageBuilder: (context, state) {
              return CustomTransitionPage(
                key: state.pageKey,
                child: const NewsPage(),
                transitionDuration: const Duration(milliseconds: 100),
                reverseTransitionDuration: const Duration(milliseconds: 100),
                transitionsBuilder: _fadeTransition,
              );
            },
          ),
          GoRoute(
              path: '/logistic',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const LogisticPage(),
                  transitionDuration: const Duration(milliseconds: 100),
                  reverseTransitionDuration: const Duration(milliseconds: 100),
                  transitionsBuilder: _fadeTransition,
                );
              },
              routes: [
                GoRoute(
                  path: 'logistic_details',
                  builder: (context, state) {
                    return LogisticStatusWithMap();
                  },
                ),
              ]),
          GoRoute(
              path: '/profile',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  key: state.pageKey,
                  child: const ProfilePage(),
                  transitionDuration: const Duration(milliseconds: 100),
                  reverseTransitionDuration: const Duration(milliseconds: 100),
                  transitionsBuilder: _fadeTransition,
                );
              },
              routes: [
                GoRoute(
                    path: 'car_details_status',
                    builder: (context, state) {
                      return CarDetailsAndStatus();
                    },
                    routes: [
                      GoRoute(
                        path: 'steps_statuses',
                        builder: (context, state) {
                          return StatusesSteps();
                        },
                      ),
                    ]),
              ]),
        ],
      ),
    ],

    // ---------- Логика редиректа на основе AuthBloc ----------
    redirect: (context, state) {
      // Достаём текущий AuthState из AuthBloc
      final authState = context.read<AuthBloc>().state;

      final isLoggingIn = state.uri.toString() == '/login' ||
          state.uri.toString() == '/register';

      // Если BLoC ещё грузится или в начальном состоянии — не перенаправляем
      if (authState is AuthInitial || authState is AuthLoading) {
        return null;
      }

      // Если пользователь залогинен, а мы пытаемся на /login или /register
      if (authState is AuthLoggedIn && isLoggingIn) {
        return '/';
      }

      // Если пользователь не залогинен, а мы пытаемся попасть куда-то не на /login|/register
      if (authState is AuthLoggedOut && !isLoggingIn) {
        return '/login';
      }

      // Иначе оставляем всё как есть
      return null;
    },
  );

  /// Пример функции анимации "Fade" (прозрачность).
  /// Можно вынести в отдельный файл, если хочется использовать многократно.
  static Widget _fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
