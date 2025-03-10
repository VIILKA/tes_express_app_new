import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import 'package:tes_test_app/core/routes/app_router.dart';
import 'package:tes_test_app/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:tes_test_app/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:tes_test_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tes_test_app/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:tes_test_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:tes_test_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:tes_test_app/features/auth/presentation/blocs/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Инициализируем SecureStorage
  final storage = FlutterSecureStorage();

  // 2. Инициализируем локальный DataSource
  final authLocalDataSource = AuthLocalDataSource(storage);

  // 3. Инициализируем HTTP-клиент и удалённый DataSource
  final httpClient = http.Client();
  final authRemoteDataSource = AuthRemoteDataSourceImpl(
    baseUrl: 'http://5.59.233.108:8081',
    client: httpClient,
  );

  // 4. Создаём репозиторий, который использует оба DataSource
  final authRepository = AuthRepositoryImpl(
    authLocalDataSource,
    authRemoteDataSource,
  );

  // 5. Запускаем приложение
  runApp(ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    builder: (context, child) {
      return MainApp(authRepository: authRepository);
    },
  ));
}

class MainApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  const MainApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // 6. Передаём репозиторий в BLoC и запускаем CheckAuth
      create: (_) {
        // 1. Создаём ваши UseCase
        final isLoggedInUseCase = IsLoggedInUseCase(authRepository);
        final loginUseCase = LoginUseCase(authRepository);
        final registerUseCase = RegisterUseCase(authRepository);

        // 2. Возвращаем AuthBloc с заполненными параметрами
        return AuthBloc(
          isLoggedInUseCase: isLoggedInUseCase,
          loginUseCase: loginUseCase,
          registerUseCase: registerUseCase,
          authRepository: authRepository,
        )..add(CheckAuth());
      },

      child: MaterialApp.router(
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
