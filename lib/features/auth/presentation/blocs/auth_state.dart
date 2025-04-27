// auth_state.dart
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

// Пользователь залогинен
class AuthLoggedIn extends AuthState {
  final bool isAdmin;
  final UserData? userData;

  const AuthLoggedIn({this.isAdmin = false, this.userData});

  @override
  List<Object?> get props => [isAdmin, userData];
}

// Пользователь разлогинен
class AuthLoggedOut extends AuthState {}

// Ошибка (например, неверный логин/пароль, ошибка сети и т.д.)
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

// Успешное выполнение операции с сообщением
class AuthSuccess extends AuthState {
  final String message;
  const AuthSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthGuest extends AuthState {
  @override
  List<Object?> get props => [];
}
