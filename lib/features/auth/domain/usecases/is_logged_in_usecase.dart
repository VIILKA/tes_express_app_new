// feature/auth/domain/usecases/is_logged_in_usecase.dart

import 'package:tes_test_app/features/auth/domain/repositories/auth_repository.dart';

enum AuthStatus { authenticated, guest, unauthenticated }

class IsLoggedInUseCase {
  final AuthRepository repository;

  IsLoggedInUseCase(this.repository);

  Future<AuthStatus> call() async {
    final isLoggedIn = await repository.isLoggedIn();
    final isGuest = await repository.isGuestMode();

    if (isLoggedIn) return AuthStatus.authenticated;
    if (isGuest) return AuthStatus.guest;
    return AuthStatus.unauthenticated;
  }
}
