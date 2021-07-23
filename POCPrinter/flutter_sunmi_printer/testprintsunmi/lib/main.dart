import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:barcode/barcode.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

@override
class _MyAppState extends State<MyApp> {
  Barcode bc;
  File img;
  void buildBarcode(
    Barcode bc,
    String data, {
    String filename,
    double width,
    double height,
    double fontHeight,
  }) async {
    /// Create the Barcode
    final svg = bc.toSvg(
      data,
      width: width ?? 200,
      height: height ?? 80,
      fontHeight: fontHeight,
    );

    // Save the image
    filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
    File('$filename.svg').writeAsStringSync(svg);
    print('$filename.svg');
  }

  void _printEN() async {
    // Test image
    ByteData bytes = await rootBundle.load('assets/images/logoapp.png');
    final buffer = bytes.buffer;
    final imgData = base64.encode(Uint8List.view(buffer));
    SunmiPrinter.image(imgData);

    SunmiPrinter.text(
      '(Business Name)',
      styles:
          SunmiStyles(size: SunmiSize.xl, align: SunmiAlign.center, bold: true),
    );
    SunmiPrinter.text(
      '(Business Caption)',
      styles: SunmiStyles(size: SunmiSize.md, align: SunmiAlign.center),
    );
    SunmiPrinter.emptyLines(3);

    SunmiPrinter.hr();
    SunmiPrinter.row(cols: [
      SunmiCol(text: '(Name and Modifiers)', width: 4),
      SunmiCol(text: '(Qty)', width: 4, align: SunmiAlign.center),
      SunmiCol(text: '(Line Total)', width: 4, align: SunmiAlign.right),
    ]);
    SunmiPrinter.hr();
    SunmiPrinter.row(cols: [
      SunmiCol(text: 'SUBTOTAL', width: 6),
      SunmiCol(text: '(subtotal)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.row(cols: [
      SunmiCol(text: 'VAT', width: 6),
      SunmiCol(text: '(Tax)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.row(cols: [
      SunmiCol(text: 'TOTAL DICOUNT', width: 6),
      SunmiCol(text: '(Discount)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.row(cols: [
      SunmiCol(text: 'SERVICE CHAGE', width: 6),
      SunmiCol(text: '(Service Chage)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.hr();
    SunmiPrinter.row(cols: [
      SunmiCol(text: 'TOTAL', width: 6),
      SunmiCol(text: '(Total Invoice)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.row(cols: [
      SunmiCol(text: 'PAID BY:(Payment Titles)', width: 6),
      SunmiCol(text: '(Payment Values)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.emptyLines(2);
    SunmiPrinter.text(
      'Thank You For Your Visit',
      styles:
          SunmiStyles(size: SunmiSize.md, align: SunmiAlign.center, bold: true),
    );
    SunmiPrinter.text(
      'Please keep for your record.',
      styles: SunmiStyles(size: SunmiSize.xs, align: SunmiAlign.center),
    );
    SunmiPrinter.hr();
    SunmiPrinter.text(
      '(Business Address)',
      styles:
          SunmiStyles(size: SunmiSize.xs, align: SunmiAlign.center, bold: true),
    );
    SunmiPrinter.text(
      '(Business Website)',
      styles:
          SunmiStyles(size: SunmiSize.xs, align: SunmiAlign.center, bold: true),
    );
    SunmiPrinter.text(
      '(Business Email)',
      styles:
          SunmiStyles(size: SunmiSize.xs, align: SunmiAlign.center, bold: true),
    );

    SunmiPrinter.emptyLines(3);
  }

  void _printTH() async {
    // Test image
    ByteData bytes = await rootBundle.load('assets/images/logoapp.png');

    final buffer = bytes.buffer;
    final imgData = base64.encode(Uint8List.view(buffer));
    SunmiPrinter.image(imgData);

    SunmiPrinter.text(
      '(ชื่อธุระกิจ)',
      styles:
          SunmiStyles(size: SunmiSize.xl, align: SunmiAlign.center, bold: true),
    );
    SunmiPrinter.text(
      '(ธุระกิจประเภทหนึ่ง)',
      styles: SunmiStyles(size: SunmiSize.md, align: SunmiAlign.center),
    );
    SunmiPrinter.emptyLines(3);

    SunmiPrinter.hr();
    SunmiPrinter.row(cols: [
      SunmiCol(text: '(ชื่อสินค้า)', width: 4),
      SunmiCol(text: '(จำนวน)', width: 4, align: SunmiAlign.center),
      SunmiCol(text: '(ราคา)', width: 4, align: SunmiAlign.right),
    ]);
    SunmiPrinter.hr();
    SunmiPrinter.row(cols: [
      SunmiCol(text: 'ยอดรวมย่อย', width: 6),
      SunmiCol(text: '(ยอดรวมย่อย)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.row(cols: [
      SunmiCol(text: 'ถาษี 7%', width: 6),
      SunmiCol(text: '(ถาษี 7%)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.row(cols: [
      SunmiCol(text: 'รวมส่วนลด', width: 6),
      SunmiCol(text: '(ส่วนลด)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.row(cols: [
      SunmiCol(text: 'ค่าบริการ', width: 6),
      SunmiCol(text: '(Service Chage)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.hr();
    SunmiPrinter.row(cols: [
      SunmiCol(text: 'ราคาราม', width: 6),
      SunmiCol(text: '(ใบแจ้งหนี้ทั้งหมด)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.row(cols: [
      SunmiCol(text: 'จ่ายโดย:(ชื่อการชำระเงิน)', width: 6),
      SunmiCol(text: '(มูลค่าการชำระเงิน)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.emptyLines(2);
    SunmiPrinter.text(
      'ขอบคุณสำหรับการเยี่ยมชมของคุณ',
      styles:
          SunmiStyles(size: SunmiSize.md, align: SunmiAlign.center, bold: true),
    );
    SunmiPrinter.text(
      'โปรดเก็บไว้เป็นหลักฐาน.',
      styles: SunmiStyles(size: SunmiSize.xs, align: SunmiAlign.center),
    );
    SunmiPrinter.hr();
    SunmiPrinter.text(
      '(ที่อยู่สถานที่ร้านค้า)',
      styles:
          SunmiStyles(size: SunmiSize.xs, align: SunmiAlign.center, bold: true),
    );
    SunmiPrinter.text(
      '(เว็บไซต์ร้านค้า)',
      styles:
          SunmiStyles(size: SunmiSize.xs, align: SunmiAlign.center, bold: true),
    );
    SunmiPrinter.text(
      '(อีเมลร้านค้า)',
      styles:
          SunmiStyles(size: SunmiSize.xs, align: SunmiAlign.center, bold: true),
    );

    SunmiPrinter.emptyLines(3);
  }

  final GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test Sunmi Printer'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Center(
                    child: Container(
                        height: 70,
                        color: Colors.white,
                        child: RepaintBoundary(
                          key: globalKey,
                          child: SfBarcodeGenerator(
                            symbology: Code128(),
                            value: 'www.syncfusion.com',
                            showValue: true,
                          ),
                        ))),
                SizedBox(height: 50),
                Container(
                    height: 200,
                    color: Colors.white,
                    child: SfBarcodeGenerator(
                      symbology: QRCode(),
                      value: 'www.syncfusion.com',
                      showValue: true,
                    )),
                SizedBox(height: 50),
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
                SizedBox(height: 50),
                Container(
                  child: QrImage(
                    data: "1234567890",
                    version: QrVersions.auto,
                    size: 200.0,
                  ),
                ),
                SizedBox(height: 50),
                RaisedButton(
                  onPressed: () {
                    buildBarcode(
                      Barcode.qrCode(),
                      'QR-Code',
                      height: 200,
                    );
                  },
                  child: const Text('cerate Barcode',
                      style: TextStyle(fontSize: 20)),
                ),
                SizedBox(height: 50),
                RaisedButton(
                  onPressed: _printEN,
                  child: const Text('Print demo EN',
                      style: TextStyle(fontSize: 20)),
                ),
                SizedBox(height: 30),
                RaisedButton(
                  onPressed: _printTH,
                  child: const Text('Print demo TH',
                      style: TextStyle(fontSize: 20)),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
