// feature/auth/presentation/bloc/auth_bloc.dart
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tes_test_app/features/auth/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<CheckAuth>(_onCheckAuth);
    on<Login>(_onLogin);
    on<Logout>(_onLogout);
    on<Register>(_onRegister);
  }

  Future<void> _onCheckAuth(CheckAuth event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final isLoggedIn = await authRepository.isLoggedIn();
    if (isLoggedIn) {
      emit(AuthLoggedIn());
    } else {
      emit(AuthLoggedOut());
    }
  }

  Future<void> _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Здесь делаем фейковую «проверку» логина/пароля
    // или если есть реальный запрос, то вызываем его через репозиторий
    final success = await authRepository.loginWithCredentials(
      event.login,
      event.password,
    );
    if (success) {
      emit(AuthLoggedIn());
    } else {
      emit(AuthError("Не удалось авторизоваться"));
      emit(AuthLoggedOut());
    }
  }

  Future<void> _onLogout(Logout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await authRepository.logout();
    emit(AuthLoggedOut());
  }

  Future<void> _onRegister(Register event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // фейковый POST запрос
    final success = await authRepository.registerUser(
      event.firstName,
      event.lastName,
      event.phoneNumber,
      event.login,
      event.password,
    );
    if (success) {
      // При удачной регистрации считаем, что он автоматически залогинен
      emit(AuthLoggedIn());
    } else {
      emit(AuthError("Не удалось зарегистрироваться"));
      emit(AuthLoggedOut());
    }
  }
}
