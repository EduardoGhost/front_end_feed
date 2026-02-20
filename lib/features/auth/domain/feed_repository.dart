import '../data/feed_remote_datasource.dart';
import '../models/post_model.dart';

class FeedRepository {
  final FeedRemoteDataSource remote;

  FeedRepository(this.remote);

  Future<List<Post>> getPosts(String username, String token) {
    return remote.getUserPosts(username, token);
  }

  Future<Post> createPost(
      String title,
      String content,
      String token,
      ) {
    final post = Post(
      title: title,
      content: content,
      createdAt: DateTime.now(),
    );

    return remote.createPost(token, post);
  }

  Future<void> deletePost(int id, String token) {
    return remote.deletePost(id, token);
  }

}
