import 'dart:io';

import 'package:mobx/mobx.dart';
import '../domain/feed_repository.dart';
import '../domain/models/post_model.dart';

part 'feed_viewmodel.g.dart';

class FeedViewModel = _FeedViewModelBase with _$FeedViewModel;

abstract class _FeedViewModelBase with Store {
  final FeedRepository repository;

  _FeedViewModelBase(this.repository);

  @observable
  ObservableList<Post> posts = ObservableList<Post>();

  @observable
  bool loading = false;

  @observable
  bool creatingPost = false;

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

  @action
  Future<void> createPost(
      String title,
      String content,
      File? imageFile,
      String token,
      // String username,
      ) async {
    creatingPost = true;

    try {
      await repository.createPost(
        title,
        content,
        imageFile,
        token,
      );

      // todo rever -> nao ha necessidade de admin
      await loadPosts("admin", token);
    } catch (e) {
      print("Erro ao criar post: $e");
    } finally {
      creatingPost = false;
    }
  }

  @action
  Future deletePost(Post post, String token) async {
    await repository.deletePost(post.id!, token);
    posts.remove(post);
  }

  Future<void> updatePost(
      int id,
      String title,
      String content,
      String token,
      ) async {
    final updated = await repository.updatePost(
      id,
      title,
      content,
      token,
    );

    final index = posts.indexWhere((p) => p.id == id);
    if (index != -1) {
      posts[index] = updated;
    }
  }

}
