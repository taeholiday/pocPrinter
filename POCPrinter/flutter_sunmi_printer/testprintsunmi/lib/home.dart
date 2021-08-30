import 'package:flutter/material.dart';
import 'package:testprintsunmi/rececipt.dart';
import 'package:testprintsunmi/testBarcode.dart';

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
            ElevatedButton(
              onPressed: () async {
                Receipt().printEN();
              },
              child:
                  const Text('Print demo EN', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                Receipt().printTH();
              },
              child:
                  const Text('Print demo TH', style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text('Print Barcode'),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => TestBarcode()));
              },
            )
          ],
        ),
      ),
    );
  }
}
