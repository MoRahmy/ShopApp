import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'Fruit.dart';

class Fruits with ChangeNotifier {
  List<Fruit> _items = [];

  List<Fruit> get items {
    return [..._items];
  }

  Future<void> fetchFruit() async {
    const url =
        "https://flutter-satrail-default-rtdb.firebaseio.com/Fruits.json";
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Fruit> loadedProdacts = [];

      if (extractedData == null) {
        return;
      }
      extractedData.forEach((prodId, prodData) {
        loadedProdacts.add(Fruit(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          url: prodData['url'],
        ));
      });

      if (response.statusCode == 200) {
        _items = loadedProdacts;
      } else {
        return null;
      }
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
