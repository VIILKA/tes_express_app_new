import 'package:tes_test_app/features/auth/domain/entities/user_login.dart';
import 'package:tes_test_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<bool> call(UserLogin user) {
    return repository.loginUser(user);
  }
}
