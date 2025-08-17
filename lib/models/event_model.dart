class Event {
  final int id;
  final String title;
  final String description;
  final String image;
  final double price;
  final String category;
  final DateTime createdAt;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
    required this.createdAt,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['thumbnail'] ?? json['images']?[0] ?? '',
      price: json['price'].toDouble(),
      category: json['category'],
      createdAt: DateTime.now().subtract(Duration(days: json['id'] % 30)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': image,
      'price': price,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String get location => 'Event Center, ${category.toUpperCase()}';
  String get formattedDate => '${createdAt.day}/${createdAt.month}/${createdAt.year}';
}