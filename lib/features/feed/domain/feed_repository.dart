import 'dart:io';
import '../data/feed_remote_datasource.dart';
import 'models/post_model.dart';

class FeedRepository {
  final FeedRemoteDataSource remote;

  FeedRepository(this.remote);

  Future<List<Post>> getPosts(String username, String token) {
    return remote.getUserPosts(username, token);
  }

  Future<Post> createPost(
      String title,
      String content,
      File? imageFile,
      String token,
      ) async {
    String? imageUrl;

    if (imageFile != null) {
      imageUrl = await remote.uploadImage(imageFile, token);
    }

    return await remote.createPost(
      title,
      content,
      imageUrl,
      token,
    );
  }

  Future<void> deletePost(int id, String token) {
    return remote.deletePost(id, token);
  }

  Future<Post> updatePost(
      int id,
      String title,
      String content,
      String token,
      ) {
    final post = Post(
      id: id,
      title: title,
      content: content,
      createdAt: DateTime.now(),
    );

    return remote.updatePost(id, post, token);
  }

}
