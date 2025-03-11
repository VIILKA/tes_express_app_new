import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:tes_test_app/core/routes/app_router.dart';
import 'package:tes_test_app/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:tes_test_app/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:tes_test_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tes_test_app/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:tes_test_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:tes_test_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:tes_test_app/features/auth/presentation/blocs/auth_bloc.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await ScreenUtil.ensureScreenSize();

  // Инициализация всех зависимостей
  final storage = FlutterSecureStorage();
  final authLocalDataSource = AuthLocalDataSource(storage);
  final httpClient = http.Client();
  final authRemoteDataSource = AuthRemoteDataSourceImpl(
    baseUrl: 'http://5.59.233.108:8081',
    client: httpClient,
  );
  final authRepository = AuthRepositoryImpl(
    authLocalDataSource,
    authRemoteDataSource,
  );

  // Проверяем состояние авторизации
  final isLoggedInUseCase = IsLoggedInUseCase(authRepository);
  final authStatus = await isLoggedInUseCase();

  // Убираем сплеш ТОЛЬКО после проверки авторизации
  FlutterNativeSplash.remove();

  runApp(ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    builder: (context, child) {
      return MainApp(
        authRepository: authRepository,
        initialAuthStatus: authStatus, // Передаем начальное состояние
      );
    },
  ));
}

class MainApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final AuthStatus initialAuthStatus;

  const MainApp({
    super.key,
    required this.authRepository,
    required this.initialAuthStatus,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final isLoggedInUseCase = IsLoggedInUseCase(authRepository);
        final loginUseCase = LoginUseCase(authRepository);
        final registerUseCase = RegisterUseCase(authRepository);

        return AuthBloc(
          isLoggedInUseCase: isLoggedInUseCase,
          loginUseCase: loginUseCase,
          registerUseCase: registerUseCase,
          authRepository: authRepository,
          initialStatus: initialAuthStatus, // Используем начальное состояние
        );
      },
      child: MaterialApp.router(
        title: 'Tes Express',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'SFProDisplay',
          scaffoldBackgroundColor: Colors.white,
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
