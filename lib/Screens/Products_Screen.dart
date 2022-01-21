import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../Classes/Fruits.dart';
import '../Widgets/App_drawer.dart';
import '../Widgets/Fruit_Item.dart';
import '../Widgets/Web_View.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var _isInit = true;
  var _isLoading = false;
  var QRcodeResult = '';
  var BcodeResult = '';

  Future<void> scanQrCode() async {
    try {
      final QRcodeResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      if (!mounted) return;

      setState(() {
        this.QRcodeResult = QRcodeResult;
      });

      if (QRcodeResult == QRcodeResult) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext ctx) => PWebView(
            title: 'Scan Result',
            url: QRcodeResult,
          ),
        ));
      }
    } on PlatformException {
      QRcodeResult = 'Failed to get platform version';
    }
  }

  Future<void> scanBCode() async {
    try {
      final BcodeResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      if (!mounted) return;

      setState(() {
        this.BcodeResult = BcodeResult;
      });

      if (BcodeResult == BcodeResult) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext ctx) => PWebView(
            title: 'Scan Result',
            url: BcodeResult,
          ),
        ));
      }
    } on PlatformException {
      BcodeResult = 'Failed to get platform version';
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Fruits>(context).fetchFruit().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Fruits>(context);
    final products = productsData.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      drawer: AppDrawer(),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: products.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: products[i],
          child: FruitItem(),
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
      ),
      floatingActionButton: RaisedButton.icon(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            content: Container(
              height: 100,
              width: double.infinity,
              color: Colors.tealAccent,
              child: Column(
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    shape: StadiumBorder(),
                    onPressed: () => Navigator.pop(context, scanQrCode()),
                    child: Text('QR Code'),
                  ),
                  FlatButton(
                    shape: StadiumBorder(),
                    onPressed: () => Navigator.pop(context, scanBCode()),
                    child: const Text('Bar Code'),
                  ),
                ],
              ),
            ),
          ),
        ),
        shape: StadiumBorder(),
        color: Colors.black12,
        icon: Icon(Icons.camera_enhance_rounded),
        label: Text(
          'Scanner',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
