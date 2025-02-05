// feature/auth/presentation/bloc/auth_event.dart
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuth extends AuthEvent {}

class Login extends AuthEvent {
  final String login;
  final String password;

  const Login(this.login, this.password);

  @override
  List<Object?> get props => [login, password];
}

class Logout extends AuthEvent {}

class Register extends AuthEvent {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String login;
  final String password;

  const Register({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.login,
    required this.password,
  });

  @override
  List<Object?> get props =>
      [firstName, lastName, phoneNumber, login, password];
}
