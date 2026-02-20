class AuthUser {
  final String token;
  final String username;

  AuthUser({
    required this.token,
    required this.username,
  });
  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      token: json['token'] as String,
      username: json['username'] as String,
    );
  }
}
