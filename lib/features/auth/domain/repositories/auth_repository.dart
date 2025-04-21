import 'package:tes_express_app_new/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_login.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_register.dart';

abstract class AuthRepository {
  Future<AuthResult> registerUser(UserRegister userRegister);

  /// Возвращает `true` при успешном логине
  Future<AuthResult> loginUser(UserLogin userLogin);

  Future<bool> isLoggedIn();

  Future<bool> isGuestMode();

  Future<void> setGuestMode(bool value);

  Future<void> logout();

  Future<void> setIsLoggedIn(bool value);

  Future<void> clearAllData();
}
