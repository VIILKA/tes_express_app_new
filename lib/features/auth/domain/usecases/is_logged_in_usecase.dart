// feature/auth/domain/usecases/is_logged_in_usecase.dart

import 'package:tes_test_app/features/auth/domain/repositories/auth_repository.dart';

class IsLoggedInUseCase {
  final AuthRepository repository;

  IsLoggedInUseCase(this.repository);

  Future<bool> call() {
    return repository.isLoggedIn();
  }
}
