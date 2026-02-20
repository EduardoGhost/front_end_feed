import 'package:dio/dio.dart';

class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(
    BaseOptions(
      //baseUrl: "http://10.0.2.2:8080", // Android emulator
      baseUrl: "http://localhost:8080", // windows
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
    ),
  );
}
