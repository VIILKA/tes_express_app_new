import 'package:tes_express_app_new/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_data.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_login.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_register.dart';

abstract class AuthRepository {
  Future<AuthResult> registerUser(UserRegister userRegister);

  /// Возвращает результат с данными пользователя при успешном логине
  Future<AuthResult> loginUser(UserLogin userLogin);

  Future<bool> isLoggedIn();

  Future<bool> isGuestMode();

  Future<void> setGuestMode(bool value);

  Future<void> logout();

  Future<void> setIsLoggedIn(bool value);

  Future<void> clearAllData();

  /// Сохранение данных пользователя
  Future<void> saveUserData(UserData userData);

  /// Получение данных пользователя
  Future<UserData?> getUserData();

  /// Удаление пользователя по ID
  /// Получает учетные данные из локального хранилища
  Future<bool> deleteUser(int userId);
}
