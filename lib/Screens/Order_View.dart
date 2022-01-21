import 'package:flutter/material.dart';

class OrderView extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String desc;

  OrderView(this.title, this.imageUrl, this.desc);

  @override
  Widget build(BuildContext context) {
    //final product = Provider.of<Fruit>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
      ),
      body: ListView(
        children: <Widget>[
          Text(
            'Thank you for buying this product',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Container(
            height: 600,
            margin: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Card(
                      child: Image.network(
                        imageUrl,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(),
                  Text(
                    desc,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    Navigator.of(context).pop();
  }
}
