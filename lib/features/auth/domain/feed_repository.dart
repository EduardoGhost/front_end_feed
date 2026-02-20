import '../data/feed_remote_datasource.dart';
import '../models/post_model.dart';

class FeedRepository {
  final FeedRemoteDataSource remote;

  FeedRepository(this.remote);

  Future<List<Post>> getPosts(String username, String token) {
    return remote.getUserPosts(username, token);
  }
}
