import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:tes_express_app_new/features/auth/domain/entities/user_login.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_register.dart';

abstract class AuthRemoteDataSource {
  Future<bool> registerUser(UserRegister userRegister);
  Future<bool> loginUser(UserLogin userLogin);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final String baseUrl;
  final http.Client client;
  final Duration timeout = const Duration(seconds: 10); // Таймаут в 10 секунд

  AuthRemoteDataSourceImpl({
    required this.baseUrl,
    required this.client,
  });

  @override
  Future<bool> registerUser(UserRegister userRegister) async {
    final url = Uri.parse('$baseUrl/api/v1/auth/register');

    final body = {
      "login": userRegister.login,
      "password": userRegister.password,
      "phoneNumber": userRegister.phoneNumber,
      "name": userRegister.name,
      "surname": userRegister.surname,
      "patronymic": userRegister.patronymic,
    };

    try {
      final response = await client
          .post(
            url,
            headers: {
              'accept': '*/*',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(timeout);

      if (response.statusCode == 201) {
        return true;
      } else {
        throw ServerException('Ошибка сервера: ${response.statusCode}');
      }
    } on TimeoutException {
      throw ServerException('Превышено время ожидания ответа от сервера');
    } on SocketException {
      throw ServerException('Отсутствует подключение к интернету');
    } catch (e) {
      throw ServerException('Произошла ошибка при регистрации');
    }
  }

  @override
  Future<bool> loginUser(UserLogin userLogin) async {
    final url = Uri.parse('$baseUrl/api/v1/auth/login');

    final body = {
      "login": userLogin.login,
      "password": userLogin.password,
    };

    try {
      final response = await client
          .post(
            url,
            headers: {
              'accept': '*/*',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(body),
          )
          .timeout(timeout);

      if (response.statusCode == 200) {
        return true;
      } else {
        throw ServerException('Ошибка сервера: ${response.statusCode}');
      }
    } on TimeoutException {
      throw ServerException('Превышено время ожидания ответа от сервера');
    } on SocketException {
      throw ServerException('Отсутствует подключение к интернету');
    } catch (e) {
      throw ServerException('Произошла ошибка при входе');
    }
  }
}

// Добавляем класс исключения
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}
