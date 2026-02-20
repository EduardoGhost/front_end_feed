import 'package:flutter/material.dart';
import '../../domain/models/post_model.dart';
import '../feed_viewmodel.dart';

class EditPostDialog extends StatefulWidget {
  final Post post;
  final FeedViewModel vm;
  final String token;

  const EditPostDialog({
    super.key,
    required this.post,
    required this.vm,
    required this.token,
  });

  @override
  State<EditPostDialog> createState() => _EditPostDialogState();
}

class _EditPostDialogState extends State<EditPostDialog> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.post.title);
    contentController = TextEditingController(text: widget.post.content);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Editar post"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: "Título"),
          ),
          TextField(
            controller: contentController,
            decoration: const InputDecoration(labelText: "Conteúdo"),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Cancelar"),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text("Salvar"),
          onPressed: () async {
            await widget.vm.updatePost(
              widget.post.id!,
              titleController.text,
              contentController.text,
              widget.token,
            );

            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}