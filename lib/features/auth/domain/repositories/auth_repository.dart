/// AuthRepository is an abstract class defining the contract for operations
/// related to data within the domain layer.
/// Concrete implementations of this repository interface will be provided
/// in the data layer to interact with specific data sources (e.g., API, database).
library;
// feature/auth/domain/repositories/auth_repository.dart

abstract class AuthRepository {
  Future<bool> isLoggedIn();

  /// Возвращает true, если логин/пароль верный
  Future<bool> loginWithCredentials(String login, String password);

  Future<void> logout();

  /// Возвращает true, если регистрация ок
  Future<bool> registerUser(
    String firstName,
    String lastName,
    String phoneNumber,
    String login,
    String password,
  );
}
