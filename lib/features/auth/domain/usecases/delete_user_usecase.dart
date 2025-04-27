import 'package:tes_express_app_new/features/auth/domain/repositories/auth_repository.dart';

class DeleteUserUseCase {
  final AuthRepository repository;

  DeleteUserUseCase(this.repository);

  /// Удаляет пользователя по его ID
  /// Возвращает true если удаление было успешным
  Future<bool> call(int userId) {
    return repository.deleteUser(userId);
  }
}
