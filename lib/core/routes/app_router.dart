import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:tes_express_app_new/core/routes/main_page.dart';
import 'package:tes_express_app_new/core/routes/route_constants.dart';
import 'package:tes_express_app_new/core/widgets/splash_page.dart';
import 'package:tes_express_app_new/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:tes_express_app_new/features/auth/presentation/screens/login_page.dart';
import 'package:tes_express_app_new/features/auth/presentation/screens/registration_page.dart';
import 'package:tes_express_app_new/features/home/presentation/screens/home_screen.dart';
import 'package:tes_express_app_new/features/logistic/presentation/screens/logistic_screen.dart';
import 'package:tes_express_app_new/features/logistic/presentation/screens/logistic_status_with_map.dart';
import 'package:tes_express_app_new/features/market/presentation/screens/market_screen.dart';
import 'package:tes_express_app_new/features/market/presentation/screens/cars_screen.dart';
import 'package:tes_express_app_new/features/market/presentation/screens/car_details_screen.dart';
import 'package:tes_express_app_new/features/news/presentation/screens/news_screen.dart';
import 'package:tes_express_app_new/features/profile/presentation/screens/car_details_and_status.dart';
import 'package:tes_express_app_new/features/profile/presentation/screens/not_registered_user_page.dart';
import 'package:tes_express_app_new/features/profile/presentation/screens/profile_screen.dart';
import 'package:tes_express_app_new/features/profile/presentation/screens/statuses_steps.dart';
import 'package:tes_express_app_new/features/profile/presentation/screens/order_history_screen.dart';

class AppRouter {
  static const _defaultTransitionDuration = Duration(milliseconds: 100);
  static const _defaultReverseTransitionDuration = Duration(milliseconds: 100);

  static final GoRouter router = GoRouter(
    // Начинаем со Splash:
    initialLocation: RouteConstants.splash,
    debugLogDiagnostics: true,

    // При необходимости делаем перенаправления:
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final currentRoute = state.uri.toString();

      // Если находимся на Splash, не перенаправляем
      if (currentRoute == RouteConstants.splash) {
        return null;
      }

      // Пример простой логики:
      if (authState is AuthLoggedOut) {
        // Если пользователь разлогинен, отправляем на /login
        // кроме случаев, когда он уже на /login или /register
        if (currentRoute != RouteConstants.login &&
            currentRoute != RouteConstants.register) {
          return RouteConstants.login;
        }
        return null;
      }

      // Если пользователь гость и пытается попасть на логистику
      if (authState is AuthGuest) {
        if (RouteConstants.isGuestRestrictedRoute(currentRoute)) {
          return RouteConstants.notRegisteredUser;
        }
      }

      // Иначе не перенаправляем
      return null;
    },

    routes: [
      // 1. Splash по пути '/'
      GoRoute(
        path: RouteConstants.splash,
        pageBuilder: (context, state) => _buildTransitionPage(
          key: state.pageKey,
          child: const SplashPage(),
        ),
      ),

      // 2. Маршруты авторизации
      GoRoute(
        path: RouteConstants.login,
        pageBuilder: (context, state) => _buildTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        path: RouteConstants.register,
        pageBuilder: (context, state) => _buildTransitionPage(
          key: state.pageKey,
          child: const RegistrationPage(),
        ),
      ),

      // 3. ShellRoute (все остальные экраны под нижней навигацией)
      ShellRoute(
        pageBuilder: (context, state, child) => _buildTransitionPage(
          key: state.pageKey,
          child: MainPage(key: MainPage.mainPageKey, child: child),
          transitionsBuilder: _slideTransition,
        ),
        routes: [
          GoRoute(
            path: RouteConstants.notRegisteredUser,
            pageBuilder: (context, state) => _buildTransitionPage(
              key: state.pageKey,
              child: const NotRegisteredUserPage(),
            ),
          ),
          GoRoute(
            path: RouteConstants.home,
            pageBuilder: (context, state) => _buildTransitionPage(
              key: state.pageKey,
              child: const HomePage(),
            ),
          ),
          GoRoute(
            path: RouteConstants.market,
            pageBuilder: (context, state) => _buildTransitionPage(
              key: state.pageKey,
              child: const MarketPage(),
            ),
            routes: [
              GoRoute(
                path: RouteConstants.cars,
                builder: (context, state) => const CarsScreen(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) {
                      final params = state.extra as Map<String, String>;
                      return CarDetailsScreen(
                        carId: params['carId']!,
                        carName: params['carName']!,
                        description: params['description']!,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: RouteConstants.news,
            pageBuilder: (context, state) => _buildTransitionPage(
              key: state.pageKey,
              child: const NewsPage(),
            ),
          ),
          GoRoute(
            path: RouteConstants.logistic,
            pageBuilder: (context, state) => _buildTransitionPage(
              key: state.pageKey,
              child: const LogisticPage(),
            ),
            routes: [
              GoRoute(
                path: RouteConstants.logisticDetails,
                pageBuilder: (context, state) => _buildTransitionPage(
                  key: state.pageKey,
                  child: LogisticStatusWithMap(),
                ),
              ),
            ],
          ),
          GoRoute(
            path: RouteConstants.profile,
            pageBuilder: (context, state) => _buildTransitionPage(
              key: state.pageKey,
              child: const ProfilePage(),
            ),
            routes: [
              GoRoute(
                path: RouteConstants.carDetailsStatus,
                pageBuilder: (context, state) => _buildTransitionPage(
                  key: state.pageKey,
                  child: CarDetailsAndStatus(
                    title: state.extra != null
                        ? (state.extra as Map<String, String>)['title']!
                        : 'Lixiang L7 Pro',
                    vinCode: state.extra != null
                        ? (state.extra as Map<String, String>)['vinCode']!
                        : 'HLX781788912311840',
                    imagePath: state.extra != null
                        ? (state.extra as Map<String, String>)['imagePath']!
                        : 'assets/images/lixiang_l7.png',
                  ),
                ),
                routes: [
                  GoRoute(
                    path: RouteConstants.stepsStatuses,
                    pageBuilder: (context, state) => _buildTransitionPage(
                      key: state.pageKey,
                      child: StatusesSteps(),
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: RouteConstants.orderHistory,
                pageBuilder: (context, state) => _buildTransitionPage(
                  key: state.pageKey,
                  child: const OrderHistoryScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static CustomTransitionPage _buildTransitionPage({
    required LocalKey key,
    required Widget child,
    RouteTransitionsBuilder transitionsBuilder = _fadeTransition,
  }) {
    return CustomTransitionPage(
      key: key,
      child: child,
      transitionDuration: _defaultTransitionDuration,
      reverseTransitionDuration: _defaultReverseTransitionDuration,
      transitionsBuilder: transitionsBuilder,
    );
  }

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

  static Widget _slideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final tween = Tween(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).chain(CurveTween(curve: Curves.easeInOut));
    return SlideTransition(
      position: animation.drive(tween),
      child: child,
    );
  }
}
