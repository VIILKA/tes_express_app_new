import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:dio/dio.dart';

import 'package:tes_express_app_new/core/routes/app_router.dart';
import 'package:tes_express_app_new/core/api/api_service.dart';
import 'package:tes_express_app_new/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:tes_express_app_new/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:tes_express_app_new/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tes_express_app_new/features/auth/domain/usecases/delete_user_usecase.dart';
import 'package:tes_express_app_new/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:tes_express_app_new/features/auth/domain/usecases/login_usecase.dart';
import 'package:tes_express_app_new/features/auth/domain/usecases/register_usecase.dart';
import 'package:tes_express_app_new/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:tes_express_app_new/features/market/data/datasources/car_remote_data_source.dart';
import 'package:tes_express_app_new/features/market/data/repositories/car_repository_impl.dart';
import 'package:tes_express_app_new/features/market/domain/usecases/get_cars.dart';
import 'package:tes_express_app_new/features/market/presentation/bloc/car_bloc.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await ScreenUtil.ensureScreenSize();

  // Инициализация всех зависимостей
  final storage = FlutterSecureStorage();
  final authLocalDataSource = AuthLocalDataSource(storage);
  final httpClient = http.Client();

  // Инициализация ApiService
  final dio = Dio();
  final apiService = ApiService(
    dio: dio,
    authLocalDataSource: authLocalDataSource,
  );

  final authRemoteDataSource = AuthRemoteDataSourceImpl(
    baseUrl: 'http://5.59.233.108:8081',
    client: httpClient,
    apiService: apiService,
  );

  final authRepository = AuthRepositoryImpl(
    authLocalDataSource,
    authRemoteDataSource,
  );

  // Инициализация зависимостей для CarBloc
  final carDataSource = CarRemoteDataSourceImpl(
    apiService: apiService,
  );
  final carRepository = CarRepositoryImpl(remoteDataSource: carDataSource);
  final getCarsUseCase = GetCars(carRepository);

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
        initialAuthStatus: authStatus,
        carRepository: carRepository,
        getCarsUseCase: getCarsUseCase,
      );
    },
  ));
}

class MainApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  final AuthStatus initialAuthStatus;
  final CarRepositoryImpl carRepository;
  final GetCars getCarsUseCase;

  const MainApp({
    super.key,
    required this.authRepository,
    required this.initialAuthStatus,
    required this.carRepository,
    required this.getCarsUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) {
            final isLoggedInUseCase = IsLoggedInUseCase(authRepository);
            final loginUseCase = LoginUseCase(authRepository);
            final registerUseCase = RegisterUseCase(authRepository);
            final deleteUserUseCase = DeleteUserUseCase(authRepository);

            return AuthBloc(
              isLoggedInUseCase: isLoggedInUseCase,
              loginUseCase: loginUseCase,
              registerUseCase: registerUseCase,
              deleteUserUseCase: deleteUserUseCase,
              authRepository: authRepository,
              initialStatus: initialAuthStatus,
            );
          },
        ),
        BlocProvider(
          create: (_) => CarBloc(carRepository: carRepository),
        ),
      ],
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
