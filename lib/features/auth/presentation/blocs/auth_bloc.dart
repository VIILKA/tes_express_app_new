import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_login.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_register.dart';
import 'package:tes_express_app_new/features/auth/domain/usecases/is_logged_in_usecase.dart';
import 'package:tes_express_app_new/features/auth/domain/usecases/login_usecase.dart';
import 'package:tes_express_app_new/features/auth/domain/usecases/register_usecase.dart';
import 'package:tes_express_app_new/features/auth/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IsLoggedInUseCase isLoggedInUseCase;
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final AuthRepository authRepository;

  AuthBloc({
    required this.isLoggedInUseCase,
    required this.loginUseCase,
    required this.registerUseCase,
    required this.authRepository,
    required AuthStatus initialStatus,
  }) : super(_mapAuthStatusToState(initialStatus)) {
    on<CheckAuth>(_onCheckAuth);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
    on<Register>(_onRegister);
    on<ContinueAsGuest>(_onContinueAsGuest);
    on<LoginAsGuest>(_onLoginAsGuest);
  }

  static AuthState _mapAuthStatusToState(AuthStatus status) {
    switch (status) {
      case AuthStatus.authenticated:
        return AuthLoggedIn();
      case AuthStatus.guest:
        return AuthGuest();
      case AuthStatus.unauthenticated:
        return AuthLoggedOut();
    }
  }

  Future<void> _onCheckAuth(CheckAuth event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
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
    } catch (e) {
      // If there's any error during auth check, default to logged out
      emit(AuthLoggedOut());
    }
  }

  Future<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    // Admin login check
    if (event.login == 'admin' && event.password == 'admin') {
      await authRepository.setIsLoggedIn(true);
      emit(AuthLoggedIn(isAdmin: true));
      return;
    }

    // Regular login logic
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

    try {
      await authRepository
          .clearAllData(); // Clear all data instead of just logout
      emit(AuthLoggedOut());
    } catch (e) {
      // Even if there's an error, ensure we emit logged out state
      emit(AuthLoggedOut());
    }
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

  Future<void> _onLoginAsGuest(
    LoginAsGuest event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      await authRepository.setIsLoggedIn(true);
      await authRepository.setGuestMode(true);
      emit(AuthGuest());
    } catch (e) {
      emit(AuthError("Ошибка при входе как гость"));
      emit(AuthLoggedOut());
    }
  }
}
