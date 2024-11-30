class Note {
  String title;
  String date;
  String content;
  final int categoryId;
  bool isFavorite;

  Note({
    required this.title,
    required this.date,
    required this.content,
    required this.categoryId,
    this.isFavorite = false, // Default tidak favorit
  });
}
