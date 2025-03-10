// feature/auth/data/datasources/auth_local_datasource.dart

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  // Ключ, по которому храним флаг залогиненности
  static const _isLoggedInKey = 'is_logged_in';
  static const _isGuestModeKey =
      'is_guest_mode'; // Добавляем ключ для гостевого режима

  final FlutterSecureStorage secureStorage;

  AuthLocalDataSource(this.secureStorage);

  Future<bool> getIsLoggedIn() async {
    // Пробуем считать строку из SecureStorage
    final boolString = await secureStorage.read(key: _isLoggedInKey);
    // Если ещё ничего не записано, возвращаем false (по умолчанию — не залогинен).
    if (boolString == null) {
      return false;
    }

    // boolString = 'true' или 'false'
    return boolString.toLowerCase() == 'true';
  }

  Future<bool> getIsGuestMode() async {
    final boolString = await secureStorage.read(key: _isGuestModeKey);
    return boolString?.toLowerCase() == 'true';
  }

  Future<void> setIsLoggedIn(bool value) async {
    // Записываем строку 'true' или 'false'
    await secureStorage.write(
      key: _isLoggedInKey,
      value: value.toString(),
    );
    if (value) {
      // Если пользователь залогинился, выключаем гостевой режим
      await setGuestMode(false);
    }
  }

  Future<void> setGuestMode(bool value) async {
    await secureStorage.write(key: _isGuestModeKey, value: value.toString());
  }
}
