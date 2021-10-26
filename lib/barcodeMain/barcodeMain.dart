import 'package:flutter/material.dart';
import 'package:testprintsunmi/barcodeMain/barcodeTypeCODABAR.dart';
import 'package:testprintsunmi/barcodeMain/barcodeTypeCODE39.dart';
import 'package:testprintsunmi/barcodeMain/barcodeTypeCODE128.dart';
import 'package:testprintsunmi/barcodeMain/barcodeTypeCODE93.dart';
import 'package:testprintsunmi/barcodeMain/barcodeTypeITF.dart';
import 'package:testprintsunmi/barcodeMain/barcodeTypeJAN13.dart';
import 'package:testprintsunmi/barcodeMain/barcodeTypeUPCE.dart';
import 'package:testprintsunmi/barcodeMain/barcodetypeJAN8.dart';
import 'package:testprintsunmi/barcodeMain/barcodetypeUPCA.dart';

class BarcodeMain extends StatefulWidget {
  BarcodeMain({Key key}) : super(key: key);

  @override
  _BarcodeMainState createState() => _BarcodeMainState();
}

class _BarcodeMainState extends State<BarcodeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Main'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("BarCodeType"),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BarcodeTypeCODE128()),
                  );
                },
                child: Text('CODE128'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BarcodeTypeCODE39()),
                  );
                },
                child: Text('CODE39'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BarcodeTypeCODABAR()),
                  );
                },
                child: Text('CODABAR'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BarcodeTypeCODE93()),
                  );
                },
                child: Text('CODE93'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BarcodeTypeUPCE()),
                  );
                },
                child: Text('UPCE'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BarcodetypeUPCA()),
                  );
                },
                child: Text('UPCA'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BarcodeTypeJAN8()),
                  );
                },
                child: Text('JAN8'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BarcodeTypeJAN13()),
                  );
                },
                child: Text('JAN13'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BarcodeTypeITF()),
                  );
                },
                child: Text('ITF'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
