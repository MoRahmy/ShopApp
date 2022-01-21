import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Fruit.dart';
import './Order.dart';

class Orders with ChangeNotifier {
  final timeStamp = DateTime.now();
  List<Order> _orders = [];

  List<Order> get orders {
    return [..._orders];
  }

  Future<void> fetchOrder() async {
    const url =
        'https://flutter-satrail-default-rtdb.firebaseio.com/requests.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Order> loadedProdacts = [];

      if (extractedData == null) {
        return;
      }
      extractedData.forEach((orderId, orderData) {
        loadedProdacts.add(Order(
          id: orderId,
          title: orderData['title'],
          price: orderData['price'],
          dateTime: DateTime.parse(orderData['dateTime']),
        ));
      });

      if (response.statusCode == 200) {
        _orders = loadedProdacts;
      } else {
        return null;
      }
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addOrder(Fruit product) async {
    const url =
        'https://flutter-satrail-default-rtdb.firebaseio.com/requests.json';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'price': product.price,
          'quantity': product.quantity,
          'dateTime': timeStamp.toIso8601String(),
        }),
      );
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
