import 'dart:typed_data';

import 'package:charset_converter/charset_converter.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:testprintsunmi/imgToByte.dart';

class CustomReceipt extends StatefulWidget {
  final int selectPaperSize;
  CustomReceipt({Key key, this.selectPaperSize}) : super(key: key);

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
  void initState() {
    super.initState();
    val = widget.selectPaperSize;
  }

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
    Uint8List encoded = await CharsetConverter.encode("TIS620", "สวัดดี");
    String decoded = await CharsetConverter.decode("TIS620", encoded);
    print(decoded);
    final profile = await CapabilityProfile.load(name: "TIS620");
    final generator =
        Generator(val == 1 ? PaperSize.mm58 : PaperSize.mm80, profile);
    List<int> bytes = [];
    int total = 0;
    // Print image:
    Uint8List byteImg = await readFileBytes('assets/images/test111.png');
    var img = decodeImage(byteImg);
    bytes += generator.image(img);
    //detail Receipt
    bytes += generator.row([
      PosColumn(
        text: decoded.toString(),
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
          styles: PosStyles(align: PosAlign.center),
        ),
        PosColumn(
          text: data[i]['price'].toString(),
          width: 6,
          styles: PosStyles(align: PosAlign.center),
        ),
        PosColumn(
          text: data[i]['total_price'].toString(),
          width: 3,
          styles: PosStyles(align: PosAlign.center),
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
    // Print Qrcode
    bytes += generator.qrcode('https://www.google.co.th/',
        size: QRSize.Size8, cor: QRCorrection.H, align: PosAlign.center);
    bytes += generator.feed(1);
    bytes += generator.feed(1);
    // Print barcode
    final List<int> barData = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 4];
    bytes += generator.barcode(Barcode.upcA(barData),
        height: 70, align: PosAlign.center);
    bytes += generator.feed(1);
    bytes += generator.text('Thank You',
        styles: PosStyles(
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ));
    // resetList and TExtStyle
    bytes += generator.reset();
    //cut Paper
    bytes += generator.cut();

    return bytes;
  }
}
