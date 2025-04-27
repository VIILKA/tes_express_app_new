// auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// Проверить, залогинен ли уже пользователь (например, при старте)
class CheckAuth extends AuthEvent {}

// Вход в систему (логин)
class Login extends AuthEvent {
  final String login;
  final String password;
  final bool isAdmin;

  const Login(this.login, this.password, {this.isAdmin = false});

  @override
  List<Object?> get props => [login, password, isAdmin];
}

// Выход из системы
class Logout extends AuthEvent {}

// Регистрация
class Register extends AuthEvent {
  final String login;
  final String password;
  final String phoneNumber;
  final String name;
  final String surname;
  final String patronymic;

  const Register({
    required this.login,
    required this.password,
    required this.phoneNumber,
    required this.name,
    required this.surname,
    required this.patronymic,
  });

  @override
  List<Object?> get props =>
      [login, password, phoneNumber, name, surname, patronymic];
}

class ContinueAsGuest extends AuthEvent {
  @override
  List<Object?> get props => [];
}

class LoginAsGuest extends AuthEvent {
  @override
  List<Object?> get props => [];
}

// Удаление аккаунта пользователя
class DeleteAccount extends AuthEvent {
  @override
  List<Object?> get props => [];
}
