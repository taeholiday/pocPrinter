import 'package:flutter/material.dart';
import 'package:testprintsunmi/syncfusion_flutter_barcodes.dart';
import 'package:testprintsunmi/rececipt.dart';
import 'package:testprintsunmi/routes.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Sunmi Printer'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () async {
                Receipt().printEN();
              },
              child:
                  const Text('Print demo EN', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () async {
                Receipt().printTH();
              },
              child:
                  const Text('Print demo TH', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SfBarcodeGenerators(
                              check: true,
                            )));
              },
              child: const Text('Print SfBarcodeGenerator Barcode',
                  style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => SfBarcodeGenerators(
                              check: false,
                            )));
              },
              child: const Text('Print SfBarcodeGenerator QRcode',
                  style: TextStyle(fontSize: 20)),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.qrImagePage);
              },
              child:
                  const Text('Print QRImage', style: TextStyle(fontSize: 20)),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.barcodes);
              },
              child:
                  const Text('Print Barcode', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
