import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import '../entity/Product.dart';
import 'package:http/http.dart' as httpClient;

class ProductProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Product findById(int id) {
    return _items.firstWhere((element) => element.id == id);
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse('http://10.0.2.2:8080/api/products');
    try {
      final response = await httpClient.get(url);
      final extractedData = json.decode(response.body)['products'] as List<dynamic>;

      final List<Product> loadedProducts = [];

      for (var element in extractedData) {
        loadedProducts.add(Product(
            id: element['id'],
            name: element['name'],
            description: element['description'],
            unitPrice: element['unitPrice'],
            imageUrl: element['imageUrl'],
        ));
      }
      _items = loadedProducts;
      notifyListeners();
    } catch(e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/products/add');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*'
    };

    try{
      final response = await httpClient.post(url, headers: headers, body: json.encode({
        'name': product.name,
        'description': product.description,
        'unitPrice': product.unitPrice,
        'imageUrl': product.imageUrl,
        'date': DateTime.now().toIso8601String(),
        'category': 'U',
      }));
      final res = json.decode(response.body);
      final newProduct = Product(
          id: res['id'],
          name: res['name'],
          description: res['description'],
          unitPrice: res['unitPrice'],
          imageUrl: res['imageUrl'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch(e) {
      rethrow;
    }
  }

  Future<void> updateProduct(Product product) async {
    final prodIndex = _items.indexWhere((element) => element.id == product.id);

    if (prodIndex > -1) {
      final url = Uri.parse('http://10.0.2.2:8080/api/products/update');
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': '*/*'
      };

      try{
        final response = await httpClient.post(url, headers: headers, body: json.encode({
          'id': product.id,
          'name': product.name,
          'description': product.description,
          'unitPrice': product.unitPrice,
          'imageUrl': product.imageUrl,
          'date': DateTime.now().toIso8601String(),
        }));
        final res = json.decode(response.body);
        final updatedProduct = Product(
          id: res['id'],
          name: res['name'],
          description: res['description'],
          unitPrice: res['unitPrice'],
          imageUrl: res['imageUrl'],
        );
        _items[prodIndex] = updatedProduct;
        notifyListeners();
      } catch(e) {
        rethrow;
      }
    } else {
      log('Problem with update product!');
    }
  }

  Future<void> deleteProduct(int id) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/products/delete/$id');

    try {
      final response = await httpClient.delete(url);
      if(response.statusCode == 204) {
        _items.removeWhere((element) => element.id == id);
        notifyListeners();
      }
    } catch(e) {
      rethrow;
    }
  }
}