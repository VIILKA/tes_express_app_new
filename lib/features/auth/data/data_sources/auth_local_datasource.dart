import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  // Keys for storing authentication state
  static const _isLoggedInKey = 'is_logged_in';
  static const _isGuestModeKey = 'is_guest_mode';
  static const _usernameKey = 'username';
  static const _passwordKey = 'password';

  final FlutterSecureStorage secureStorage;

  AuthLocalDataSource(this.secureStorage);

  Future<bool> getIsLoggedIn() async {
    try {
      final boolString = await secureStorage.read(key: _isLoggedInKey);
      // If nothing is stored yet, return false (not logged in by default)
      if (boolString == null) {
        return false;
      }
      return boolString.toLowerCase() == 'true';
    } catch (e) {
      // If there's any error reading from secure storage, default to not logged in
      return false;
    }
  }

  Future<bool> getIsGuestMode() async {
    try {
      final boolString = await secureStorage.read(key: _isGuestModeKey);
      return boolString?.toLowerCase() == 'true';
    } catch (e) {
      // If there's any error, default to not guest mode
      return false;
    }
  }

  Future<void> setIsLoggedIn(bool value) async {
    try {
      // Write 'true' or 'false' string
      await secureStorage.write(
        key: _isLoggedInKey,
        value: value.toString(),
      );

      if (value) {
        // If user is logged in, turn off guest mode
        await setGuestMode(false);
      }
    } catch (e) {
      // Handle error if needed
      rethrow;
    }
  }

  Future<void> setGuestMode(bool value) async {
    try {
      await secureStorage.write(key: _isGuestModeKey, value: value.toString());
    } catch (e) {
      // Handle error if needed
      rethrow;
    }
  }

  Future<void> clearAllData() async {
    try {
      // Clear all authentication data
      await secureStorage.delete(key: _isLoggedInKey);
      await secureStorage.delete(key: _isGuestModeKey);
      await secureStorage.delete(key: _usernameKey);
      await secureStorage.delete(key: _passwordKey);
    } catch (e) {
      // Handle error if needed
      rethrow;
    }
  }

  // Новые методы для работы с credentials
  Future<void> saveCredentials(String username, String password) async {
    await secureStorage.write(key: _usernameKey, value: username);
    await secureStorage.write(key: _passwordKey, value: password);
  }

  Future<Map<String, String?>> getCredentials() async {
    final username = await secureStorage.read(key: _usernameKey);
    final password = await secureStorage.read(key: _passwordKey);
    return {
      'username': username,
      'password': password,
    };
  }
}
