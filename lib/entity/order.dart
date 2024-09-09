import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_app/entity/cart.dart';

import 'package:http/http.dart' as httpClient;

class Order {
  final String orderTrackingNumber;
  final double totalPrice;
  final List<CartItem> cartItems;
  final DateTime dateTime;

  Order({
    required this.orderTrackingNumber,
    required this.totalPrice,
    required this.cartItems,
    required this.dateTime
  });
}

class Orders with ChangeNotifier {
  final String authToken;

  List<Order> _orders = [];

  Orders(this.authToken, this._orders);

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    final url = Uri.parse('http://10.0.2.2:8080/api/orders/user');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $authToken',

    };

    final response = await httpClient.get(url, headers: headers);

    final extractedData = json.decode(response.body)['orders'] as List<dynamic>;
    if (extractedData.isEmpty) {
      return;
    }

    final List<Order> loadedOrders = [];

    for(var element in extractedData) {
      List<CartItem> items = (element['orderItems'] as List<dynamic>).map((item) => CartItem(
        productId: item['productId'],
        name: item['title'],
        quantity: item['quantity'],
        unitPrice: item['unit'],
      )).toList();

      loadedOrders.add(
          Order(
            orderTrackingNumber: element['orderTrackingNumber'],
            totalPrice: element['total'],
            dateTime: DateTime.parse(element['dateCreated']).toLocal(),
            cartItems: items,
          )
      );
      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    }
  }

  Future<void> addOrder(List<CartItem> cartItems, double total) {
    final url = Uri.parse('http://10.0.2.2:8080/api/checkout');
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $authToken',

    };

    return httpClient.post(url, headers: headers, body: json.encode({
      'name': 'my name',
      'address': '204/39 QL13',
      'total': total,
      'items': cartItems.map((e) => {
        'imageUrl': 'abc',
        'title': e.name,
        'qty': e.quantity,
        'unit': e.unitPrice,
        'id': e.productId,
      }).toList()
    })).then((result) {
      String orderTrackingNo = DateTime.now().microsecondsSinceEpoch.toString();
      DateTime dateCreated = DateTime.now();

      try {
        orderTrackingNo = json.decode(result.body)['orderTrackingNumber'];
        dateCreated = DateTime.parse(json.decode(result.body)['dateCreated']).toLocal();
      } on FormatException catch (e) {
        log('Message return is not a valid Json format');
      }
      _orders.insert(0, Order(
          orderTrackingNumber: orderTrackingNo,
          totalPrice: total,
          cartItems: cartItems,
          dateTime: dateCreated)
      );
      notifyListeners();
    });
  }
}
