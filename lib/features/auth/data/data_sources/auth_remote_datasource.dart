import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tes_test_app/features/auth/domain/entities/user_login.dart';
import 'package:tes_test_app/features/auth/domain/entities/user_register.dart';

abstract class AuthRemoteDataSource {
  Future<bool> registerUser(UserRegister userRegister);
  Future<bool> loginUser(UserLogin userLogin);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final String baseUrl;
  final http.Client client;

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

    final response = await client.post(
      url,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 201) {
      // Успешно. (Возможно, придёт json-ответ, который нужно распарсить.)
      return true;
    } else {
      // Ошибка
      print(response.statusCode);
      return false;
    }
  }

  @override
  Future<bool> loginUser(UserLogin userLogin) async {
    final url = Uri.parse('$baseUrl/api/v1/auth/login');

    final body = {
      "login": userLogin.login,
      "password": userLogin.password,
    };

    final response = await client.post(
      url,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      // Успешно. (Тут тоже, возможно, надо распарсить токен.)
      return true;
    } else {
      return false;
    }
  }
}
