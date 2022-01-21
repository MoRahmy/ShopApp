import 'package:flutter/foundation.dart';

class Fruit with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String url;
  int quantity = 0;

  Fruit({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.url,
    this.quantity,
  });
}
