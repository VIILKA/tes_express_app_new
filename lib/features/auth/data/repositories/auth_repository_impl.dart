import 'package:tes_express_app_new/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:tes_express_app_new/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_data.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_login.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_register.dart';
import 'package:tes_express_app_new/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<AuthResult> registerUser(UserRegister userRegister) async {
    try {
      final success = await remoteDataSource.registerUser(userRegister);
      if (success) {
        await localDataSource.setIsLoggedIn(true);
        await localDataSource.saveCredentials(
            userRegister.login, userRegister.password);

        // Создаем базовые данные пользователя из информации при регистрации
        final userData = UserData(
          id: 0, // Временный ID, будет обновлен при следующем входе
          login: userRegister.login,
          phoneNumber: userRegister.phoneNumber,
          name: userRegister.name,
          surname: userRegister.surname,
          patronymic: userRegister.patronymic,
          role: UserRole(
              id: 1, name: "CLIENT"), // Предполагаем роль клиента по умолчанию
          accepted: false, // Предполагаем, что аккаунт требует подтверждения
        );

        // Сохраняем данные пользователя
        await localDataSource.saveUserData(userData);

        return AuthResult(success: true, userData: userData);
      }
      return AuthResult(success: false, error: 'Не удалось зарегистрироваться');
    } on ServerException catch (e) {
      return AuthResult(success: false, error: e.message);
    } catch (e) {
      return AuthResult(success: false, error: 'Произошла неизвестная ошибка');
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
    } on ServerException catch (e) {
      return AuthResult(success: false, error: e.message);
    } catch (e) {
      return AuthResult(
          success: false, error: 'Произошла неизвестная ошибка: $e');
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
