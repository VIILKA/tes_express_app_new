import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:tes_express_app_new/features/auth/data/data_sources/auth_local_datasource.dart';

// Класс для представления серверных ошибок
class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  ApiException({required this.message, this.statusCode, this.data});

  @override
  String toString() => 'ApiException: $message (statusCode: $statusCode)';
}

class ApiService {
  final Dio dio;
  final AuthLocalDataSource authLocalDataSource;
  final String baseUrl = 'http://5.59.233.108:8081/api';

  ApiService({
    required this.dio,
    required this.authLocalDataSource,
  }) {
    // Настройка базового URL и таймаутов
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);
    dio.options.sendTimeout = const Duration(seconds: 10);

    // Добавляем интерцептор для логирования
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (object) => developer.log(object.toString()),
    ));

    // Добавляем интерцептор для обработки ошибок
    dio.interceptors.add(InterceptorsWrapper(
      onError: (DioException error, ErrorInterceptorHandler handler) async {
        developer.log('API Ошибка: ${error.message}', error: error);

        // Преобразуем DioException в более понятное ApiException
        final statusCode = error.response?.statusCode;
        String message;

        if (error.type == DioExceptionType.connectionTimeout ||
            error.type == DioExceptionType.receiveTimeout ||
            error.type == DioExceptionType.sendTimeout) {
          message = 'Превышено время ожидания ответа от сервера';
        } else if (error.type == DioExceptionType.connectionError) {
          message = 'Отсутствует подключение к интернету';
        } else if (statusCode == 401) {
          message = 'Неверный логин или пароль';
        } else if (statusCode == 403) {
          message = 'Доступ запрещён';
        } else if (statusCode == 404) {
          if (error.requestOptions.path.contains('/auth/login')) {
            message =
                'Сервис авторизации временно недоступен. Пожалуйста, попробуйте позже.';
          } else {
            message = 'Запрашиваемый ресурс не найден';
          }
        } else if (statusCode == 409) {
          message = 'Конфликт данных';
        } else {
          // Пытаемся извлечь сообщение об ошибке из ответа
          try {
            final data = error.response?.data;
            if (data != null && data is Map && data.containsKey('message')) {
              message = data['message'];
            } else {
              message = 'Ошибка сервера: ${statusCode ?? "неизвестная ошибка"}';
            }
          } catch (e) {
            message = 'Непредвиденная ошибка: ${error.message}';
          }
        }

        throw ApiException(
          message: message,
          statusCode: statusCode,
          data: error.response?.data,
        );
      },
    ));
  }

  // Получаем заголовки для BasicAuth
  Future<Options> _getAuthOptions() async {
    try {
      final credentials = await authLocalDataSource.getCredentials();
      final username = credentials['username'] ?? '';
      final password = credentials['password'] ?? '';

      // Если учетные данные пользователя пусты, используем фиксированные данные "string:string"
      String basicAuth;
      if (username.isEmpty || password.isEmpty) {
        developer
            .log('API: Использую стандартные учетные данные (string:string)');
        basicAuth = 'Basic ${base64Encode(utf8.encode('string:string'))}';
      } else {
        developer.log('API: Аутентификация с username: $username');
        basicAuth = 'Basic ${base64Encode(utf8.encode('$username:$password'))}';
      }

      return Options(
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );
    } catch (e) {
      developer.log(
          'API: Ошибка получения данных аутентификации, использую резервные данные',
          error: e);
      // Возвращаем базовые заголовки с фиксированной авторизацией
      final basicAuth = 'Basic ${base64Encode(utf8.encode('string:string'))}';
      return Options(
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/json',
          'Accept': '*/*',
        },
      );
    }
  }

  // Получаем заголовки с фиксированными учетными данными string:string
  Options _getAdminAuthOptions() {
    developer.log(
        'API: Использую админские учетные данные (string:string) для доступа к маркету');
    final basicAuth = 'Basic ${base64Encode(utf8.encode('string:string'))}';
    return Options(
      headers: {
        'Authorization': basicAuth,
        'Content-Type': 'application/json',
        'Accept': '*/*',
      },
    );
  }

  // GET запрос
  Future<Response> get(String path) async {
    try {
      final options = await _getAuthOptions();
      developer.log('API GET: $path');
      return await dio.get(path, options: options);
    } catch (e) {
      // DioException будет перехвачен interceptor'ом и преобразован в ApiException
      rethrow;
    }
  }

  // GET запрос с админскими правами (для маркета)
  Future<Response> getWithAdminAuth(String path) async {
    try {
      final options = _getAdminAuthOptions();
      developer.log('API GET (админский доступ): $path');
      return await dio.get(path, options: options);
    } catch (e) {
      // DioException будет перехвачен interceptor'ом и преобразован в ApiException
      rethrow;
    }
  }

  // POST запрос
  Future<Response> post(String path, {dynamic data}) async {
    try {
      final options = await _getAuthOptions();
      developer.log('API POST: $path');
      return await dio.post(path, data: data, options: options);
    } catch (e) {
      rethrow;
    }
  }

  // POST запрос с админскими правами (для маркета)
  Future<Response> postWithAdminAuth(String path, {dynamic data}) async {
    try {
      final options = _getAdminAuthOptions();
      developer.log('API POST (админский доступ): $path');
      return await dio.post(path, data: data, options: options);
    } catch (e) {
      rethrow;
    }
  }

  // PUT запрос
  Future<Response> put(String path, {dynamic data}) async {
    try {
      final options = await _getAuthOptions();
      developer.log('API PUT: $path');
      return await dio.put(path, data: data, options: options);
    } catch (e) {
      rethrow;
    }
  }

  // DELETE запрос
  Future<Response> delete(String path, {dynamic data}) async {
    try {
      final options = await _getAuthOptions();
      developer.log('API DELETE: $path');
      return await dio.delete(path, data: data, options: options);
    } catch (e) {
      rethrow;
    }
  }
}
