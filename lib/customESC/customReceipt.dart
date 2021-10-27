import 'dart:typed_data';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class CustomReceipt extends StatefulWidget {
  CustomReceipt({Key key}) : super(key: key);

  @override
  _CustomReceiptState createState() => _CustomReceiptState();
}

class _CustomReceiptState extends State<CustomReceipt> {
  int val = 1;
  final List<Map<String, dynamic>> data = [
    {
      'title': 'lay',
      'price': 100,
      'qty': 2,
      'total_price': 200,
    },
    {
      'title': 'pepsi',
      'price': 200,
      'qty': 2,
      'total_price': 400,
    },
    {
      'title': 'coca cola',
      'price': 120,
      'qty': 1,
      'total_price': 120,
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
                  child: ElevatedButton(
                    child: Text('Print Receipt'),
                    onPressed: () async {
                      await printReceiptCustom();
                    },
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                Expanded(
                    child: Row(
                  children: [
                    Text('set PaperSize'),
                    Radio(
                      value: 1,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text('58 mm.'),
                    SizedBox(
                      width: 20.0,
                    ),
                    Radio(
                      value: 2,
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {
                          val = value;
                        });
                      },
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text('80 mm.'),
                    SizedBox(
                      width: 20.0,
                    ),
                  ],
                )),
                SizedBox(width: 20),
              ],
            ),
          )
        ],
      ),
    );
  }

  printReceiptCustom() async {
    final List<int> _escPos = await _customEscPos();
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printRawData(Uint8List.fromList(_escPos));
    await SunmiPrinter.exitTransactionPrint(true);
  }

  Future<List<int>> _customEscPos() async {
    final profile = await CapabilityProfile.load();
    final generator =
        Generator(val == 1 ? PaperSize.mm58 : PaperSize.mm80, profile);
    List<int> bytes = [];
    int total = 0;
    bytes += generator.row([
      PosColumn(
        text: 'productName x amount',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'price',
        width: 6,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'total',
        width: 3,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);

    for (var i = 0; i < data.length; i++) {
      total += data[i]['total_price'];
      bytes += generator.row([
        PosColumn(
          text: '${data[i]['title']} x ${data[i]['qty']}',
          width: 3,
          styles: PosStyles(align: PosAlign.center, underline: true),
        ),
        PosColumn(
          text: data[i]['price'].toString(),
          width: 6,
          styles: PosStyles(align: PosAlign.center, underline: true),
        ),
        PosColumn(
          text: data[i]['total_price'].toString(),
          width: 3,
          styles: PosStyles(align: PosAlign.center, underline: true),
        ),
      ]);
    }

    bytes += generator.feed(1);
    bytes += generator.row([
      PosColumn(
        text: 'Total',
        width: 6,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
      PosColumn(
        text: 'Rp $total',
        width: 6,
        styles: PosStyles(align: PosAlign.center, underline: true),
      ),
    ]);
    bytes += generator.feed(1);
    bytes += generator.text('Thank You',
        styles: PosStyles(align: PosAlign.center, bold: true));

    bytes += generator.reset();
    bytes += generator.cut();

    return bytes;
  }
}
