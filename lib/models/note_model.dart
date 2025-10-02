class NoteModel {
  final String id; // علشان نخزن الـ documentId
  final String title;
  final String content;
  final DateTime createdAt;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
});

  factory NoteModel.fromJson(Map<String, dynamic> json, String id,DateTime createdAt) {
    return NoteModel(
      id: id,
      title: json['title'] ?? '',
      content: json['content'] ?? '', createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'createdAt': createdAt,
    };
  }
}
