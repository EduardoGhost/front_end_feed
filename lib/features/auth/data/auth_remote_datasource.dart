import 'package:dio/dio.dart';
import '../domain/auth_repository.dart';
import '../domain/entities/auth_user.dart';


class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<AuthUser> login(String username, String password) async {
    final response = await dio.post('/auth/login', data: {
      'username': username,
      'password': password,
    });

    return AuthUser.fromJson(response.data);
  }
}


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<AuthUser> login(String username, String password) {
    return remote.login(username, password);
  }
}

