import 'package:tes_express_app_new/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tes_express_app_new/features/auth/domain/entities/user_register.dart';
import 'package:tes_express_app_new/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<AuthResult> call(UserRegister user) {
    return repository.registerUser(user);
  }
}
