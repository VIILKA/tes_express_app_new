import 'package:tes_express_app_new/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:tes_express_app_new/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_data.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_login.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_register.dart';
import 'package:tes_express_app_new/features/auth/domain/repositories/auth_repository.dart';
import 'dart:developer' as developer;

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<AuthResult> registerUser(UserRegister userRegister) async {
    try {
      // Получаем данные пользователя с сервера после регистрации
      final userData = await remoteDataSource.registerUser(userRegister);

      // Сохраняем данные авторизации и пользователя
      await localDataSource.setIsLoggedIn(true);
      await localDataSource.saveCredentials(
          userRegister.login, userRegister.password);
      await localDataSource.saveUserData(userData);

      return AuthResult(success: true, userData: userData);
    } on AuthException catch (e) {
      developer.log('Ошибка регистрации: ${e.message}');
      return AuthResult(success: false, error: e.message);
    } catch (e) {
      developer.log('Неизвестная ошибка регистрации', error: e);
      return AuthResult(
          success: false, error: 'Произошла неизвестная ошибка: $e');
    }
  }

  @override
  Future<AuthResult> loginUser(UserLogin userLogin) async {
    try {
      // Получаем данные пользователя при входе
      final userData = await remoteDataSource.loginUser(userLogin);

      // Если успешно получили данные, сохраняем их
      await localDataSource.setIsLoggedIn(true);
      await localDataSource.saveCredentials(
          userLogin.login, userLogin.password);
      await localDataSource.saveUserData(userData);

      return AuthResult(success: true, userData: userData);
    } on AuthException catch (e) {
      developer.log('Ошибка входа: ${e.message}');
      return AuthResult(success: false, error: e.message);
    } catch (e) {
      developer.log('Неизвестная ошибка входа', error: e);
      return AuthResult(
          success: false, error: 'Произошла неизвестная ошибка: $e');
    }
  }

  @override
  Future<bool> deleteUser(int userId) async {
    try {
      // Вызываем удаление пользователя
      final success = await remoteDataSource.deleteUser(userId);

      if (success) {
        // Если удаление успешно, очищаем все локальные данные
        await clearAllData();
        return true;
      }
      return false;
    } on AuthException catch (e) {
      developer.log('Ошибка при удалении пользователя: ${e.message}');
      return false;
    } catch (e) {
      developer.log('Неизвестная ошибка при удалении пользователя', error: e);
      return false;
    }
  }

  @override
  Future<bool> isLoggedIn() => localDataSource.getIsLoggedIn();

  @override
  Future<bool> isGuestMode() => localDataSource.getIsGuestMode();

  @override
  Future<void> setGuestMode(bool value) => localDataSource.setGuestMode(value);

  @override
  Future<void> logout() async {
    await localDataSource.clearAllData();
  }

  @override
  Future<void> setIsLoggedIn(bool value) async {
    await localDataSource.setIsLoggedIn(value);
  }

  @override
  Future<void> clearAllData() async {
    await localDataSource.clearAllData();
  }

  @override
  Future<void> saveUserData(UserData userData) async {
    await localDataSource.saveUserData(userData);
  }

  @override
  Future<UserData?> getUserData() async {
    return await localDataSource.getUserData();
  }
}

// Обновляем класс для результата авторизации
class AuthResult {
  final bool success;
  final String? error;
  final UserData? userData;

  AuthResult({
    required this.success,
    this.error,
    this.userData,
  });
}
