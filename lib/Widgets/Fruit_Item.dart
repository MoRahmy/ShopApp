import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Web_View.dart';
import '../Screens/Order_View.dart';
import '../Classes/Orders.dart';
import '../Classes/Fruit.dart';

class FruitItem extends StatefulWidget {
  @override
  _FruitItemState createState() => _FruitItemState();
}

class _FruitItemState extends State<FruitItem> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Fruit>(context, listen: false);

    buyNow() {
      try {
        Provider.of<Orders>(context, listen: false).addOrder(products);
      } catch (error) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An error occurred!'),
                  content: Text('Something went wrong.'),
                  actions: <Widget>[
                    FlatButton(
                        child: Text('Okay'),
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        })
                  ],
                ));
      }
    }

    /*_launchURL() async {
      final url = '${products.url}';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }*/

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            products.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black26,
          leading: Consumer<Fruit>(
            builder: (ctx, products, _) => IconButton(
              icon: Icon(Icons.add),
              onPressed: () => {
                (Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => OrderView(
                      products.title,
                      products.imageUrl,
                      products.description,
                    ),
                  ),
                )),
                buyNow(),
              },
            ),
          ),
          title: Text(
            products.title,
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            '${products.price}\$',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.language),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext ctx) => PWebView(
                  title: products.title,
                  url: products.url,
                ),
              ));
            },
          ),
        ),
      ),
    );
  }
}
