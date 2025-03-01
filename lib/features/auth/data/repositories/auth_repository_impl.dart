import 'package:tes_test_app/features/auth/data/data_sources/auth_local_datasource.dart';
import 'package:tes_test_app/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:tes_test_app/features/auth/domain/entities/user_login.dart';
import 'package:tes_test_app/features/auth/domain/entities/user_register.dart';
import 'package:tes_test_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<bool> registerUser(UserRegister userRegister) async {
    final success = await remoteDataSource.registerUser(userRegister);
    if (success) {
      await localDataSource.setIsLoggedIn(true);
    }
    return success;
  }

  @override
  Future<bool> loginUser(UserLogin userLogin) async {
    final success = await remoteDataSource.loginUser(userLogin);
    if (success) {
      await localDataSource.setIsLoggedIn(true);
    }
    return success;
  }

  @override
  Future<bool> isLoggedIn() {
    return localDataSource.getIsLoggedIn();
  }

  @override
  Future<void> logout() {
    return localDataSource.setIsLoggedIn(false);
  }
}
