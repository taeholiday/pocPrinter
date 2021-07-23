import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/material.dart';
import 'package:printertext/print.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

class Home extends StatelessWidget {
  //
  /// Example Data
  final List<Map<String, dynamic>> data = [
    {
      'title': 'Produk 1',
      'price': 10000,
      'qty': 2,
      'total_price': 20000,
    },
    {
      'title': 'Produk 2',
      'price': 20000,
      'qty': 2,
      'total_price': 40000,
    },
    {
      'title': 'Produk 3',
      'price': 12000,
      'qty': 1,
      'total_price': 12000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    int _total = 0;

    for (var i = 0; i < data.length; i++) {
      _total += data[i]['total_price'];
    }

    return Scaffold(
      appBar: AppBar(title: Text('Thermal Printer')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (c, i) {
                return ListTile(
                  title: Text(data[i]['title']),
                  subtitle: Text('Rp ${data[i]['price']} x ${data[i]['qty']}'),
                  trailing: Text('Rp ${data[i]['total_price']}'),
                );
              },
            ),
          ),
          Container(
            height: 70,
            color: Colors.white,
            child: SfBarcodeGenerator(
              symbology: Code128(),
              value: 'www.syncfusion.com',
              showValue: true,
            ),
          ),
          Container(
            height: 100,
            color: Colors.white,
            child: SfBarcodeGenerator(
              symbology: QRCode(),
              value: 'www.syncfusion.com',
              showValue: true,
            ),
          ),
          Container(
            child: BarCodeImage(
              params: Code39BarCodeParams(
                "1234ABCD",
                lineWidth:
                    2.0, // width for a single black/white bar (default: 2.0)
                barHeight:
                    90.0, // height for the entire widget (default: 100.0)
                withText:
                    true, // Render with text label or not (default: false)
              ),
              onError: (error) {
                // Error handler
                print('error = $error');
              },
            ),
          ),
          Container(
            child: QrImage(
              data: "1234567890",
              version: QrVersions.auto,
              size: 200.0,
            ),
          ),
          Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Total :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Rp $_total :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(width: 20),
                Expanded(
                  child: FlatButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text('Print'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Print(data)));
                    },
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
