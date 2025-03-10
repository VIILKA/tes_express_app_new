import 'package:tes_test_app/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:tes_test_app/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:tes_test_app/features/auth/domain/entities/user_login.dart';
import 'package:tes_test_app/features/auth/domain/entities/user_register.dart';
import 'package:tes_test_app/features/auth/domain/repositories/auth_repository.dart';

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
        return AuthResult(success: true);
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
      final success = await remoteDataSource.loginUser(userLogin);
      if (success) {
        await localDataSource.setIsLoggedIn(true);
        return AuthResult(success: true);
      }
      return AuthResult(success: false, error: 'Не удалось войти в систему');
    } on ServerException catch (e) {
      return AuthResult(success: false, error: e.message);
    } catch (e) {
      return AuthResult(success: false, error: 'Произошла неизвестная ошибка');
    }
  }

  @override
  Future<bool> isLoggedIn() => localDataSource.getIsLoggedIn();

  @override
  Future<bool> isGuestMode() => localDataSource.getIsGuestMode();

  @override
  Future<void> setGuestMode(bool value) => localDataSource.setGuestMode(value);

  @override
  Future<void> logout() {
    return localDataSource.setIsLoggedIn(false);
  }
}

// Добавляем класс для результата авторизации
class AuthResult {
  final bool success;
  final String? error;

  AuthResult({required this.success, this.error});
}
