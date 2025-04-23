class UserData {
  final int id;
  final String login;
  final String phoneNumber;
  final String name;
  final String surname;
  final String? patronymic;
  final UserRole role;
  final bool accepted;

  UserData({
    required this.id,
    required this.login,
    required this.phoneNumber,
    required this.name,
    required this.surname,
    this.patronymic,
    required this.role,
    required this.accepted,
  });

  // Фабричный метод для создания из JSON
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] as int,
      login: json['login'] as String,
      phoneNumber: json['phoneNumber'] as String,
      name: json['name'] as String,
      surname: json['surname'] as String,
      patronymic: json['patronomic'] as String?, // Учтем опечатку в API
      role: UserRole.fromJson(json['role'] as Map<String, dynamic>),
      accepted: json['accepted'] as bool,
    );
  }

  // Метод для сериализации в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'phoneNumber': phoneNumber,
      'name': name,
      'surname': surname,
      'patronomic': patronymic, // Учтем опечатку в API
      'role': role.toJson(),
      'accepted': accepted,
    };
  }
}

class UserRole {
  final int id;
  final String name;

  UserRole({
    required this.id,
    required this.name,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) {
    return UserRole(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
