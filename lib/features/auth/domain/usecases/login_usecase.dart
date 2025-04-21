import 'package:tes_express_app_new/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_login.dart';
import 'package:tes_express_app_new/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<AuthResult> call(UserLogin user) {
    return repository.loginUser(user);
  }
}
