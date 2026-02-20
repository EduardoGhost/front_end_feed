import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../data/feed_remote_datasource.dart';
import '../models/post_model.dart';
import 'create_post_dialog.dart';
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

  void _confirmDelete(BuildContext context, Post post) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Deletar post"),
        content: const Text("Tem certeza que deseja deletar este post?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          TextButton(
            onPressed: () async {
              await vm.deletePost(post, token);
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Post deletado")),
              );
            },
            child: const Text("Deletar"),
          ),
        ],
      ),
    );
  }

  Widget _postCard(BuildContext context, Post post) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: ListTile(
        title: Text(post.title),
        subtitle: Text(post.content),
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'delete') {
              _confirmDelete(context, post);
            }
            if (value == 'edit') {
              // todo implementar
            }
          },
          itemBuilder: (_) => const [
            PopupMenuItem(
              value: 'edit',
              child: Text('Editar'),
            ),
            PopupMenuItem(
              value: 'delete',
              child: Text('Deletar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    vm.loadPosts(username, token);

    return Scaffold(
      appBar: AppBar(title: const Text("Feed")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => CreatePostDialog(
              vm: vm,
              token: token,
            ),
          );
        },
      ),
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
              return _postCard(context, post);
            },
          );
        },
      ),
    );
  }
}