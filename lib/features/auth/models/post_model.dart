class Post {
  final int? id;
  final String title;
  final String content;
  final String? imageUrl;
  final DateTime createdAt;

  Post({
    this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.createdAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json['id'],
    title: json['title'],
    content: json['content'],
    imageUrl: json['imageUrl'],
    createdAt: DateTime.parse(json['createdAt']),
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
  };

}
