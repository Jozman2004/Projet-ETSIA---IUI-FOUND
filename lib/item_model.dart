// lib/item_model.dart

class Item {
  final String title;
  final String subtitle;
  final String date;
  final String time;
  final String description;
  final List<String> tags;
  final String highlightedTag;
  final String? imageUrl; // Pour une future image

  const Item({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.time,
    required this.description,
    required this.tags,
    required this.highlightedTag,
    this.imageUrl,
  });
}