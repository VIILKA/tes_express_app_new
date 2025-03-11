import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthLocalDataSource {
  // Keys for storing authentication state
  static const _isLoggedInKey = 'is_logged_in';
  static const _isGuestModeKey = 'is_guest_mode';
  static const String _tokenKey = 'auth_token';

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

  Future<void> saveToken(String token) async {
    try {
      await secureStorage.write(key: _tokenKey, value: token);
    } catch (e) {
      // Handle error if needed
      rethrow;
    }
  }

  Future<String?> getToken() async {
    try {
      return await secureStorage.read(key: _tokenKey);
    } catch (e) {
      // Handle error if needed
      return null;
    }
  }

  Future<void> clearAllData() async {
    try {
      // Clear all authentication data
      await secureStorage.delete(key: _isLoggedInKey);
      await secureStorage.delete(key: _isGuestModeKey);
      await secureStorage.delete(key: _tokenKey);
      // Alternative: clear everything
      // await secureStorage.deleteAll();
    } catch (e) {
      // Handle error if needed
      rethrow;
    }
  }
}
