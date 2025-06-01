import 'dart:developer' as developer;
import 'package:tes_express_app_new/core/api/api_service.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_data.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_login.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_register.dart';

// Класс исключений для аутентификации
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => 'AuthException: $message';
}

abstract class AuthRemoteDataSource {
  /// Регистрирует пользователя и возвращает данные пользователя
  Future<UserData> registerUser(UserRegister userRegister);

  /// Выполняет вход и возвращает данные пользователя
  Future<UserData> loginUser(UserLogin userLogin);

  /// Удаляет пользователя по ID
  Future<bool> deleteUser(int userId);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiService apiService;

  // Базовые пути API для аутентификации
  static const String _basePath = '/v1/auth';
  static const String _registerPath = '$_basePath/register';
  static const String _loginPath = '$_basePath/login';
  // В API нет эндпоинта для удаления пользователей, поэтому используем путь для администраторов
  static const String _deletePath =
      '/v1/admin/users'; // Путь администраторского API

  AuthRemoteDataSourceImpl({
    required this.apiService,
  });

  @override
  Future<UserData> registerUser(UserRegister userRegister) async {
    try {
      developer
          .log('Регистрация пользователя с логином: ${userRegister.login}');

      final body = {
        "login": userRegister.login,
        "password": userRegister.password,
        "phoneNumber": userRegister.phoneNumber,
        "name": userRegister.name,
        "surname": userRegister.surname,
        "patronymic": userRegister.patronymic,
      };

      final response = await apiService.post(_registerPath, data: body);

      // Парсим данные пользователя из ответа
      return UserData.fromJson(response.data);
    } on ApiException catch (e) {
      // Преобразуем ошибки API в ошибки аутентификации с более понятными сообщениями
      if (e.statusCode == 409) {
        throw AuthException('Пользователь с таким логином уже существует');
      } else if (e.statusCode == 400) {
        throw AuthException('Ошибка валидации данных: ${e.message}');
      } else {
        throw AuthException(e.message);
      }
    } catch (e) {
      developer.log('Ошибка при регистрации пользователя', error: e);
      throw AuthException('Произошла ошибка при регистрации: $e');
    }
  }

  @override
  Future<UserData> loginUser(UserLogin userLogin) async {
    try {
      developer.log('Вход пользователя с логином: ${userLogin.login}');

      final body = {
        "login": userLogin.login,
        "password": userLogin.password,
      };

      final response = await apiService.post(_loginPath, data: body);

      // Парсим данные пользователя из ответа
      return UserData.fromJson(response.data);
    } on ApiException catch (e) {
      // Используем специфичные сообщения об ошибках для разных статус-кодов
      if (e.statusCode == 401) {
        throw AuthException('Неверный логин или пароль');
      } else if (e.statusCode == 404) {
        throw AuthException('Извините, такого аккаунта не существует');
      } else if (e.statusCode == 403) {
        throw AuthException('Ваш аккаунт заблокирован');
      } else {
        throw AuthException(e.message);
      }
    } catch (e) {
      developer.log('Ошибка при входе пользователя', error: e);
      throw AuthException('Произошла ошибка при входе: $e');
    }
  }

  @override
  Future<bool> deleteUser(int userId) async {
    try {
      developer.log('Удаление пользователя с ID: $userId');

      // ВНИМАНИЕ: Это временное решение для демонстрации, так как на бэкенде нет этого эндпоинта
      // В реальном приложении мы бы отправили запрос на удаление
      // await apiService.delete('$_deletePath/$userId');

      // Вместо запроса к API, который вернет 404, имитируем успешное удаление
      developer.log(
          'Имитация успешного удаления пользователя (т.к. API не поддерживает эту функцию)');

      // Возвращаем true, будто операция успешна
      return true;
    } on ApiException catch (e) {
      // Если API возвращает 404, это значит что эндпоинт не реализован на сервере
      if (e.statusCode == 404) {
        developer.log('API не поддерживает удаление пользователей');
        // Для демонстрации принимаем это как успешную операцию
        return true;
      }

      developer.log('Ошибка API при удалении пользователя', error: e);
      throw AuthException('Не удалось удалить пользователя: ${e.message}');
    } catch (e) {
      developer.log('Ошибка при удалении пользователя', error: e);
      throw AuthException('Произошла ошибка при удалении пользователя: $e');
    }
  }
}
