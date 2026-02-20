import 'package:mobx/mobx.dart';
import '../domain/feed_repository.dart';
import '../models/post_model.dart';

part 'feed_viewmodel.g.dart';

class FeedViewModel = _FeedViewModelBase with _$FeedViewModel;

abstract class _FeedViewModelBase with Store {
  final FeedRepository repository;

  _FeedViewModelBase(this.repository);

  @observable
  ObservableList<Post> posts = ObservableList<Post>();

  @observable
  bool loading = false;

  @action
  Future<void> loadPosts(String username, String token) async {
    loading = true;
    try {
      final fetched = await repository.getPosts(username, token);
      posts = ObservableList<Post>.of(fetched);
    } finally {
      loading = false;
    }
  }
}
