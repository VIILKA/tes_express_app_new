import 'package:tes_test_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tes_test_app/features/auth/domain/entities/user_login.dart';
import 'package:tes_test_app/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthResult> call(UserLogin user) {
    return repository.loginUser(user);
  }
}
