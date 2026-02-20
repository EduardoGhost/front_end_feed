// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FeedViewModel on _FeedViewModelBase, Store {
  late final _$postsAtom =
      Atom(name: '_FeedViewModelBase.posts', context: context);

  @override
  ObservableList<Post> get posts {
    _$postsAtom.reportRead();
    return super.posts;
  }

  @override
  set posts(ObservableList<Post> value) {
    _$postsAtom.reportWrite(value, super.posts, () {
      super.posts = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_FeedViewModelBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$creatingPostAtom =
      Atom(name: '_FeedViewModelBase.creatingPost', context: context);

  @override
  bool get creatingPost {
    _$creatingPostAtom.reportRead();
    return super.creatingPost;
  }

  @override
  set creatingPost(bool value) {
    _$creatingPostAtom.reportWrite(value, super.creatingPost, () {
      super.creatingPost = value;
    });
  }

  late final _$loadPostsAsyncAction =
      AsyncAction('_FeedViewModelBase.loadPosts', context: context);

  @override
  Future<void> loadPosts(String username, String token) {
    return _$loadPostsAsyncAction.run(() => super.loadPosts(username, token));
  }

  late final _$createPostAsyncAction =
      AsyncAction('_FeedViewModelBase.createPost', context: context);

  @override
  Future<void> createPost(String title, String content, String token) {
    return _$createPostAsyncAction
        .run(() => super.createPost(title, content, token));
  }

  late final _$deletePostAsyncAction =
      AsyncAction('_FeedViewModelBase.deletePost', context: context);

  @override
  Future<dynamic> deletePost(Post post, String token) {
    return _$deletePostAsyncAction.run(() => super.deletePost(post, token));
  }

  @override
  String toString() {
    return '''
posts: ${posts},
loading: ${loading},
creatingPost: ${creatingPost}
    ''';
  }
}
