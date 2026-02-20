import 'package:flutter/material.dart';
import '../data/feed_remote_datasource.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'feed_viewmodel.dart';
import '../../core/dio_client.dart';
import '../domain/feed_repository.dart';

class FeedPage extends StatelessWidget {
  final String username;
  final String token;

  FeedPage({super.key, required this.username, required this.token});

  final vm = FeedViewModel(
    FeedRepository(
      FeedRemoteDataSource(DioClient()),
    ),
  );



  @override
  Widget build(BuildContext context) {
    final username = "admin"; // temporário

    vm.loadPosts(username, token);

    return Scaffold(
      appBar: AppBar(title: const Text("Feed")),
      body: Observer(
        builder: (_) {
          if (vm.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (vm.posts.isEmpty) {
            return const Center(child: Text("Nenhum post encontrado"));
          }

          return ListView.builder(
            itemCount: vm.posts.length,
            itemBuilder: (_, index) {
              final post = vm.posts[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.content),
                  trailing: Text(
                    "${post.createdAt.hour}:${post.createdAt.minute.toString().padLeft(2,'0')}",
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

