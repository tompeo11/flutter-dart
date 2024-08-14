import 'package:flutter/material.dart';
import '../entity/Product.dart';


class ProductsProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(id: 1, name: 'Machine Learning: 4 Books in 1', description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', unitPrice: 35.01, imageUrl: 'https://i.postimg.cc/rF9fSZg4/BOOK-PROGRAMMING-1011.jpg',),
    Product(id: 2, name: 'Beginning Programming All-in-One', description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', unitPrice: 32.89, imageUrl: 'https://i.postimg.cc/vBLVpk4L/BOOK-PROGRAMMING-1010.jpg',),
    Product(id: 3, name: 'Head First Design Patterns', description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', unitPrice: 32.43, imageUrl: 'https://i.postimg.cc/4NF9kzxM/BOOK-PROGRAMMING-1009.jpg',),
    Product(id: 4, name: 'Effective C', description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', unitPrice: 35.01, imageUrl: 'https://i.postimg.cc/sXyB9mTB/BOOK-PROGRAMMING-1008.jpg',),
    Product(id: 5, name: 'Computer Programming: The Bible', description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', unitPrice: 14.95, imageUrl: 'https://i.postimg.cc/4NMmFs8R/BOOK-PROGRAMMING-1007.jpg',),
    Product(id: 6, name: 'The Self-Taught Programmer', description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', unitPrice: 21.87, imageUrl: 'https://i.postimg.cc/Dwk7XZj0/BOOK-PROGRAMMING-1006.jpg',),
    Product(id: 7, name: 'Python Programming for Beginners', description: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', unitPrice: 21.99, imageUrl: 'https://i.postimg.cc/wBFzZk6R/BOOK-PROGRAMMING-1005.jpg',),
  ];

  List<Product> get items {
    return [..._items];
  }

  Product findById(int id) {
    return _items.firstWhere((element) => element.id == id);
  }

  List<Product> get getFavoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  void addProduct(Product product) {
    Product productWithMaxId = _items.reduce((result, element) => result.id > element.id ? result : element);

    final newProduct = Product(
      id: productWithMaxId.id + 1,
      name: product.name,
      description: product.description,
      unitPrice: product.unitPrice,
      imageUrl: product.imageUrl
    );

    _items.add(newProduct);

    notifyListeners();
  }
}