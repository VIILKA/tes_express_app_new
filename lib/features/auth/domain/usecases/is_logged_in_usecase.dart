import 'package:tes_express_app_new/features/auth/domain/repositories/auth_repository.dart';

enum AuthStatus {
  authenticated,
  guest,
  unauthenticated,
}

class IsLoggedInUseCase {
  final AuthRepository repository;

  IsLoggedInUseCase(this.repository);

  Future<AuthStatus> call() async {
    try {
      final isLoggedIn = await repository.isLoggedIn();

      if (isLoggedIn) {
        return AuthStatus.authenticated;
      }

      final isGuest = await repository.isGuestMode();

      if (isGuest) {
        return AuthStatus.guest;
      }

      return AuthStatus.unauthenticated;
    } catch (e) {
      // If there's any error, default to unauthenticated
      return AuthStatus.unauthenticated;
    }
  }
}
