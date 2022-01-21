import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import './Screens/Products_Screen.dart';
import './Screens/Order_Screen.dart';
import './Classes/Fruits.dart' show Fruits;
import './Classes/Orders.dart' show Orders;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Fruits(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          accentColor: Colors.lightBlueAccent,
        ),
        home: Products(),
        routes: {
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
