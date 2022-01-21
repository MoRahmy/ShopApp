import 'package:flutter/foundation.dart';

class Order with ChangeNotifier {
  final String id;
  final String title;
  final double price;
  int quantity = 0;
  final DateTime dateTime;

  Order({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.dateTime,
    this.quantity,
  });
}
