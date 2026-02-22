import 'dart:io';
import 'package:dio/dio.dart';
import '../../core/dio_client.dart';
import '../domain/models/post_model.dart';

class FeedRemoteDataSource {
  final Dio dio;

  FeedRemoteDataSource(DioClient client) : dio = client.dio;

  Future<List<Post>> getUserPosts(String username, String token) async {
    final response = await dio.get(
      '/posts',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return (response.data as List)
        .map((json) => Post.fromJson(json))
        .toList();
  }

  Future<Post> createPost(
      String title,
      String content,
      String? imageUrl,
      String token,
      ) async {
    final response = await dio.post(
      '/posts',
      data: {
        "title": title,
        "content": content,
        "imageUrl": imageUrl,
      },
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    return Post.fromJson(response.data);
  }

  Future<void> deletePost(int id, String token) async {
    await dio.delete(
      '/posts/$id',
      options: Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );
  }

  Future<Post> updatePost(int id, Post post, String token) async {
    final response = await dio.put(
      '/posts/$id',
      data: post.toJson(),
      options: Options(headers: {
        'Authorization': 'Bearer $token',
      }),
    );

    return Post.fromJson(response.data);
  }


  Future<String> uploadImage(File image, String token) async {
    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(image.path),
    });

    final response = await dio.post(
      "/posts/upload",
      data: formData,
      options: Options(headers: {
        "Authorization": "Bearer $token",
      }),
    );

    return response.data;
  }

}
