// feature/auth/data/datasources/auth_local_datasource.dart

class AuthLocalDataSource {
  // Допустим, что у нас в памяти хранится bool.
  bool _isLoggedIn = true;

  Future<bool> getIsLoggedIn() async {
    // В реальном случае тут будет чтение из SharedPreferences / SecureStorage
    return _isLoggedIn;
  }

  Future<void> setIsLoggedIn(bool value) async {
    // В реальном случае тут будет запись в SharedPreferences / SecureStorage
    _isLoggedIn = value;
  }
}
