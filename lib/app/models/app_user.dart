enum UserType {
  newUser,
  pollo,
  transfer,
  admin,
}

extension UserTypeExtension on UserType {
  String get string {
    switch (this) {
      case UserType.newUser:
        return 'newUser';
      case UserType.pollo:
        return 'pollo';
      case UserType.transfer:
        return 'transfer';
      case UserType.admin:
        return 'admin';
    }
  }

  static UserType fromString(String str) {
    switch (str) {
      case 'newUser':
        return UserType.newUser;
      case 'coord':
        return UserType.pollo;
      case 'pollo':
        return UserType.pollo;
      case 'admin':
        return UserType.admin;
      default:
        throw ArgumentError('Invalid user type: $str');
    }
  }
}

class AppUser {
  final String id;

  final String email;
  final UserType type;

  AppUser({
    required this.id,
    required this.email,
    required this.type,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'],
      email: json['email'],
      type: UserTypeExtension.fromString(json['type']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'type': type.string,
    };
  }
}
