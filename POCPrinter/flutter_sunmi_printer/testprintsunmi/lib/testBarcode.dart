import 'package:flutter/material.dart';
import 'package:testprintsunmi/barcodeQrcodeGenerator/barcode_flutter.dart';
import 'package:testprintsunmi/barcodeQrcodeGenerator/qr_flutter.dart';
import 'package:testprintsunmi/barcodeQrcodeGenerator/syncfusion_flutter_barcodes.dart';

class TestBarcode extends StatefulWidget {
  TestBarcode({Key key}) : super(key: key);

  @override
  _TestBarcodeState createState() => _TestBarcodeState();
}

class _TestBarcodeState extends State<TestBarcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Barcode/QRcode'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => QRImage()));
              },
              child: const Text('Print qr_flutter',
                  style: TextStyle(fontSize: 20)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => BarcodeImage()));
              },
              child:
                  const Text('barcode_flutter', style: TextStyle(fontSize: 20)),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SfBarcodeGenerators(
                              check: true,
                            )));
              },
              child: const Text('syncfusion_flutter_barcodes',
                  style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
