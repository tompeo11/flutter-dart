import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final int id;
  final String name;
  final String description;
  final double unitPrice;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.unitPrice,
    required this.imageUrl,
    this.isFavorite = false
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }
}