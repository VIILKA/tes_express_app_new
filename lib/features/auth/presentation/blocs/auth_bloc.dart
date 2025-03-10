import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_test_app/features/auth/domain/entities/user_login.dart';
import 'package:tes_test_app/features/auth/domain/entities/user_register.dart';
import 'package:tes_test_app/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:tes_test_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:tes_test_app/features/auth/domain/usecases/register_usecase.dart';
import 'package:tes_test_app/features/auth/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IsLoggedInUseCase isLoggedInUseCase;
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final AuthRepository
      authRepository; // или можно сделать отдельный LogoutUseCase

  AuthBloc({
    required this.isLoggedInUseCase,
    required this.loginUseCase,
    required this.registerUseCase,
    required this.authRepository,
  }) : super(AuthInitial()) {
    on<CheckAuth>(_onCheckAuth);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
    on<Register>(_onRegister);
    on<ContinueAsGuest>(_onContinueAsGuest);
  }

  Future<void> _onCheckAuth(CheckAuth event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final status = await isLoggedInUseCase();

    switch (status) {
      case AuthStatus.authenticated:
        emit(AuthLoggedIn());
        break;
      case AuthStatus.guest:
        emit(AuthGuest());
        break;
      case AuthStatus.unauthenticated:
        emit(AuthLoggedOut());
        break;
    }
  }

  Future<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final userLogin = UserLogin(login: event.login, password: event.password);
    final result = await loginUseCase(userLogin);

    if (result.success) {
      emit(AuthLoggedIn());
    } else {
      emit(AuthError("Не удалось авторизоваться"));
      emit(AuthLoggedOut());
    }
  }

  Future<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    await authRepository.logout(); // или создайте LogoutUseCase
    emit(AuthLoggedOut());
  }

  Future<void> _onRegister(Register event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final userRegister = UserRegister(
      login: event.login,
      password: event.password,
      phoneNumber: event.phoneNumber,
      name: event.name,
      surname: event.surname,
      patronymic: event.patronymic,
    );

    final result = await registerUseCase(userRegister);

    if (result.success) {
      emit(AuthLoggedIn());
    } else {
      emit(AuthError(result.error ?? "Не удалось зарегистрироваться"));
      emit(AuthLoggedOut());
    }
  }

  Future<void> _onContinueAsGuest(
      ContinueAsGuest event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await authRepository.setGuestMode(true);
    emit(AuthGuest());
  }
}
