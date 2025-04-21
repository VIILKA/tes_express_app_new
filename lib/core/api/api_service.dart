import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:tes_express_app_new/features/auth/data/data_sources/auth_local_datasource.dart';

class ApiService {
  final Dio dio;
  final AuthLocalDataSource authLocalDataSource;
  final String baseUrl = 'http://5.59.233.108:8081/api';

  ApiService({
    required this.dio,
    required this.authLocalDataSource,
  });

  Future<Options> _getOptions() async {
    try {
      final credentials = await authLocalDataSource.getCredentials();
      final username = credentials['username'] ?? 'string';
      final password = credentials['password'] ?? 'string';

      developer.log('API: Аутентификация с username: $username');

      final basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';

      return Options(
        headers: {
          'Authorization': basicAuth,
          'Content-Type': 'application/json',
        },
      );
    } catch (e) {
      developer.log('API: Ошибка получения данных аутентификации', error: e);
      // Возвращаем базовые заголовки без авторизации
      return Options(
        headers: {
          'Content-Type': 'application/json',
        },
      );
    }
  }

  Future<Response> get(String path) async {
    try {
      final options = await _getOptions();
      final url = '$baseUrl$path';

      developer.log('API GET: $url');

      final response = await dio.get(url, options: options);

      developer.log('API Ответ: ${response.statusCode}');

      return response;
    } catch (e) {
      developer.log('API GET Ошибка: $path', error: e);
      rethrow;
    }
  }

  Future<Response> post(String path, {dynamic data}) async {
    try {
      final options = await _getOptions();
      final url = '$baseUrl$path';

      developer.log('API POST: $url');
      developer.log('API Данные: $data');

      final response = await dio.post(url, data: data, options: options);

      developer.log('API Ответ: ${response.statusCode}');

      return response;
    } catch (e) {
      developer.log('API POST Ошибка: $path', error: e);
      rethrow;
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      final options = await _getOptions();
      return await dio.put('$baseUrl$path', data: data, options: options);
    } catch (e) {
      developer.log('API PUT Ошибка: $path', error: e);
      rethrow;
    }
  }

  Future<Response> delete(String path) async {
    try {
      final options = await _getOptions();
      return await dio.delete('$baseUrl$path', options: options);
    } catch (e) {
      developer.log('API DELETE Ошибка: $path', error: e);
      rethrow;
    }
  }
}
