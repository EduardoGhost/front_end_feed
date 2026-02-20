import 'package:dio/dio.dart';
import '../../core/dio_client.dart';
import '../models/post_model.dart';

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

  Future<Post> createPost(String token, Post post) async {
    final response = await dio.post(
      '/posts',
      data: post.toJson(),
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

}
