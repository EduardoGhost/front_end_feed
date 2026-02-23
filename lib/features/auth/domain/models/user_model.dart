import '../entities/auth_user.dart';

class UserModel extends AuthUser {
  UserModel({
    required super.token,
    required super.username,

  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'],
      username: json['username'],

    );
  }
}
