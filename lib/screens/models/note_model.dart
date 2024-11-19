class Note {
  String title;
  String date;
  String content;
  bool isFavorite;

  Note({
    required this.title,
    required this.date,
    required this.content,
    this.isFavorite = false, // Default tidak favorit
  });
}
