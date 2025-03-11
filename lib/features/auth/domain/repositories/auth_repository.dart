import 'package:tes_test_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tes_test_app/features/auth/domain/entities/user_login.dart';
import 'package:tes_test_app/features/auth/domain/entities/user_register.dart';

abstract class AuthRepository {
  Future<AuthResult> registerUser(UserRegister userRegister);

  /// Возвращает `true` при успешном логине
  Future<AuthResult> loginUser(UserLogin userLogin);

  Future<bool> isLoggedIn();

  Future<bool> isGuestMode();

  Future<void> setGuestMode(bool value);

  Future<void> logout();

  Future<void> saveToken(String token);

  Future<void> clearAllData();
}
