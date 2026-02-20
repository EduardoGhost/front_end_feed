import 'package:flutter/material.dart';

import '../../domain/models/post_model.dart';

Widget optionCardWidget(
    Post post, {
      required VoidCallback onDelete,
      required VoidCallback onEdit,
    }) {
  return Card(
    margin: const EdgeInsets.all(8),
    child: ListTile(
      title: Text(post.title),
      subtitle: Text(post.content),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'delete') onDelete();
          if (value == 'edit') onEdit();
        },
        itemBuilder: (context) => const [
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