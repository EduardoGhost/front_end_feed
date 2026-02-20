import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'feed_viewmodel.dart';


class CreatePostDialog extends StatelessWidget {
  final FeedViewModel vm;
  final String token;

  CreatePostDialog({
    super.key,
    required this.vm,
    required this.token,
  });

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Novo Post"),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Título",
              ),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: "Conteúdo",
              ),
              maxLines: 4,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Cancelar"),
          onPressed: () => Navigator.pop(context),
        ),
        Observer(
          builder: (_) => ElevatedButton(
            onPressed: vm.creatingPost
                ? null
                : () async {
              if (titleController.text.isEmpty ||
                  contentController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Preencha todos os campos"),
                  ),
                );
                return;
              }

              await vm.createPost(
                titleController.text,
                contentController.text,
                token,
              );

              Navigator.pop(context);
            },
            child: vm.creatingPost
                ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : const Text("Publicar"),
          ),
        )
      ],
    );
  }
}