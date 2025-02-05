import 'package:tes_test_app/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:tes_test_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.localDataSource);

  @override
  Future<bool> isLoggedIn() {
    return localDataSource.getIsLoggedIn();
  }

  @override
  Future<bool> loginWithCredentials(String login, String password) async {
    // Фейковая логика
    if (login == "user" && password == "123") {
      await localDataSource.setIsLoggedIn(true);
      return true;
    }
    return false;
  }

  @override
  Future<void> logout() {
    return localDataSource.setIsLoggedIn(false);
  }

  @override
  Future<bool> registerUser(
    String firstName,
    String lastName,
    String phoneNumber,
    String login,
    String password,
  ) async {
    // Фейковый POST-запрос
    // Тут можно проверить, что login уникален и т.д.
    // Если всё ок, сохраняем, что пользователь залогинился
    await localDataSource.setIsLoggedIn(true);
    return true;
  }
}
