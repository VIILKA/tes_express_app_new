import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:tes_express_app_new/core/api/api_service.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_data.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_login.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_register.dart';

abstract class AuthRemoteDataSource {
  /// Регистрирует пользователя и возвращает данные пользователя
  Future<UserData> registerUser(UserRegister userRegister);

  /// Выполняет вход и возвращает данные пользователя
  Future<UserData> loginUser(UserLogin userLogin);

  /// Удаляет пользователя по ID
  Future<bool> deleteUser(int userId);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final String baseUrl;
  final http.Client client;
  final Duration timeout = const Duration(seconds: 10); // Таймаут в 10 секунд
  final ApiService? apiService; // Опциональное поле для ApiService

  AuthRemoteDataSourceImpl({
    required this.baseUrl,
    required this.client,
    this.apiService,
  });

  @override
  Future<UserData> registerUser(UserRegister userRegister) async {
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
        // Парсим данные пользователя из ответа
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return UserData.fromJson(jsonData);
      } else if (response.statusCode == 400) {
        // Пытаемся получить сообщение об ошибке из тела ответа
        try {
          final errorData = jsonDecode(response.body);
          final errorMessage =
              errorData['message'] ?? 'Ошибка валидации данных';
          throw ServerException(errorMessage);
        } catch (e) {
          throw ServerException('Ошибка валидации данных при регистрации');
        }
      } else if (response.statusCode == 409) {
        throw ServerException('Пользователь с таким логином уже существует');
      } else {
        throw ServerException('Ошибка сервера: ${response.statusCode}');
      }
    } on TimeoutException {
      throw ServerException('Превышено время ожидания ответа от сервера');
    } on SocketException {
      throw ServerException('Отсутствует подключение к интернету');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Произошла ошибка при регистрации: $e');
    }
  }

  @override
  Future<UserData> loginUser(UserLogin userLogin) async {
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
        // Парсим данные пользователя из ответа
        final Map<String, dynamic> jsonData = jsonDecode(response.body);
        return UserData.fromJson(jsonData);
      } else if (response.statusCode == 401) {
        throw ServerException('Неверный логин или пароль');
      } else if (response.statusCode == 404) {
        throw ServerException('Извините, такого аккаунта не существует');
      } else if (response.statusCode == 403) {
        throw ServerException('Ваш аккаунт заблокирован');
      } else if (response.statusCode == 400) {
        // Пытаемся получить сообщение об ошибке из тела ответа
        try {
          final errorData = jsonDecode(response.body);
          final errorMessage =
              errorData['message'] ?? 'Ошибка в запросе авторизации';
          throw ServerException(errorMessage);
        } catch (e) {
          throw ServerException('Ошибка в запросе авторизации');
        }
      } else {
        throw ServerException('Ошибка сервера: ${response.statusCode}');
      }
    } on TimeoutException {
      throw ServerException('Превышено время ожидания ответа от сервера');
    } on SocketException {
      throw ServerException(
          'Отсутствует подключение к интернету. Проверьте подключение и попробуйте снова');
    } catch (e) {
      if (e is ServerException) rethrow;
      throw ServerException('Произошла ошибка при входе: $e');
    }
  }

  @override
  Future<bool> deleteUser(int userId) async {
    if (apiService == null) {
      throw ServerException('ApiService не инициализирован');
    }

    try {
      developer.log('Удаление пользователя с ID: $userId');

      final response = await apiService!.delete('/dictionary/$userId');

      developer.log('Ответ API: статус ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 204) {
        developer.log('Пользователь успешно удален');
        return true;
      } else {
        developer
            .log('Ошибка при удалении пользователя: ${response.statusCode}');
        throw ServerException(
            'Ошибка при удалении пользователя: ${response.statusCode}');
      }
    } catch (e) {
      developer.log('Исключение при удалении пользователя', error: e);
      if (e is ServerException) rethrow;
      throw ServerException('Произошла ошибка при удалении пользователя: $e');
    }
  }
}

// Добавляем класс исключения
class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}
