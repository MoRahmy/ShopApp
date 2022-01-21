import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'Web_View.dart';

class PQRCode extends StatefulWidget {
  @override
  _PQRCodeState createState() => _PQRCodeState();
}

class _PQRCodeState extends State<PQRCode> {
  String codeResult = '';

  @override
  Widget build(BuildContext context) {
    Future<void> scanQrCode() async {
      try {
        final codeResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666',
          'Cancel',
          true,
          ScanMode.QR,
        );
        if (!mounted) return;

        setState(() {
          this.codeResult = codeResult;
        });

        if (codeResult == codeResult) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext ctx) => PWebView(
              title: 'Scan Result',
              url: codeResult,
            ),
          ));
        }
      } on PlatformException {
        codeResult = 'Failed to get platform version';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 75),
            RaisedButton(
              child: Text(
                'Scan QR-Code',
                style: TextStyle(fontSize: 24),
              ),
              shape: StadiumBorder(),
              color: Colors.black12,
              onPressed: scanQrCode,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 9),
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
