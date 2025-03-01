import 'package:tes_test_app/features/auth/domain/entities/user_login.dart';
import 'package:tes_test_app/features/auth/domain/entities/user_register.dart';

abstract class AuthRepository {
  Future<bool> registerUser(UserRegister userRegister);

  /// Возвращает `true` при успешном логине
  Future<bool> loginUser(UserLogin userLogin);

  Future<bool> isLoggedIn();

  Future<void> logout();
}
