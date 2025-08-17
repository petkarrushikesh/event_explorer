import 'package:flutter/material.dart';

class Offer {
  final int id;
  final String title;
  final String description;
  final int discountPercentage;
  final DateTime validUntil;
  final String imageUrl;
  final String category;
  final bool isActive;

  Offer({
    required this.id,
    required this.title,
    required this.description,
    required this.discountPercentage,
    required this.validUntil,
    required this.imageUrl,
    required this.category,
    this.isActive = true,
  });

  factory Offer.fromJson(Map<String, dynamic> json) {
    return Offer(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      discountPercentage: json['discountPercentage'],
      validUntil: DateTime.parse(json['validUntil']),
      imageUrl: json['imageUrl'] ?? 'https://picsum.photos/400/300?random=1',
      category: json['category'],
      isActive: json['isActive'] ?? true,
    );
  }

  String get displayCategory => category.isNotEmpty ? category : 'General';

  String get formattedValidUntil => '${validUntil.day}/${validUntil.month}/${validUntil.year}';

  Color get categoryColor {
    switch (category.toLowerCase()) {
      case 'student':
        return Colors.blue;
      case 'group':
        return Colors.green;
      case 'early bird':
        return Colors.orange;
      case 'vip':
        return Colors.purple;
      case 'weekend':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  bool get isExpired => DateTime.now().isAfter(validUntil);
}