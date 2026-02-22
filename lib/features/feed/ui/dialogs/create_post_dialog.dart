import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../feed_viewmodel.dart';

class CreatePostDialog extends StatefulWidget {
  final FeedViewModel vm;
  final String token;


  const CreatePostDialog({
    super.key,
    required this.vm,
    required this.token,
  });

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();


  File? selectedImage;
  final picker = ImagePicker();

  Future<void> pickImage() async {
    final picked = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 85,
    );

    if (picked != null) {
      setState(() {
        selectedImage = File(picked.path);
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

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
              decoration: const InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(labelText: "Conteúdo"),
              maxLines: 4,
            ),

            const SizedBox(height: 12),

            ElevatedButton.icon(
              onPressed: pickImage,
              icon: const Icon(Icons.image),
              label: const Text("Selecionar imagem"),
            ),

            if (selectedImage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(selectedImage!, height: 150),
                ),
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
            onPressed: widget.vm.creatingPost
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

              await widget.vm.createPost(
                titleController.text,
                contentController.text,
                selectedImage,
                widget.token,
                // widget.username,
              );

              Navigator.pop(context);
            },
            child: widget.vm.creatingPost
                ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : const Text("Publicar"),
          ),
        ),
      ],
    );
  }
}