import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_test_app/core/routes/app_router.dart';
import 'package:tes_test_app/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:tes_test_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tes_test_app/features/auth/presentation/blocs/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authLocalDataSource = AuthLocalDataSource();
  final authRepository = AuthRepositoryImpl(authLocalDataSource);

  runApp(MainApp(authRepository: authRepository));
}

class MainApp extends StatelessWidget {
  final AuthRepositoryImpl authRepository;
  const MainApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(authRepository)..add(CheckAuth()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'SFProDisplay', scaffoldBackgroundColor: Colors.white),
        routerConfig: AppRouter.router,
      ),
    );
  }
}
