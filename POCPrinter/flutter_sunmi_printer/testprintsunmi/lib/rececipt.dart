import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';

class Receipt {
  Receipt();
  printEN() async {
    // Test image
    ByteData bytes = await rootBundle.load('assets/images/logomiapp.png');
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

    // Test imageBarcode
    ByteData bytesbar = await rootBundle.load('assets/images/barcodeAndQR.jpg');
    final bufferbar = bytesbar.buffer;
    final imgDatabar = base64.encode(Uint8List.view(bufferbar));
    SunmiPrinter.image(imgDatabar);

    SunmiPrinter.emptyLines(3);
  }

  printTH() async {
    // Test image
    ByteData bytes = await rootBundle.load('assets/images/logomiapp.png');
    final buffer = bytes.buffer;
    final imgData = base64.encode(Uint8List.view(buffer));
    SunmiPrinter.image(imgData);

    SunmiPrinter.text(
      '(?????????????????????????????????)',
      styles:
          SunmiStyles(size: SunmiSize.xl, align: SunmiAlign.center, bold: true),
    );
    SunmiPrinter.text(
      '(??????????????????????????????????????????????????????)',
      styles: SunmiStyles(size: SunmiSize.md, align: SunmiAlign.center),
    );
    SunmiPrinter.emptyLines(3);

    SunmiPrinter.hr();
    SunmiPrinter.row(cols: [
      SunmiCol(text: '(??????????????????????????????)', width: 4),
      SunmiCol(text: '(???????????????)', width: 4, align: SunmiAlign.center),
      SunmiCol(text: '(????????????)', width: 4, align: SunmiAlign.right),
    ]);
    SunmiPrinter.hr();
    SunmiPrinter.row(cols: [
      SunmiCol(text: '??????????????????????????????', width: 6),
      SunmiCol(text: '(??????????????????????????????)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.row(cols: [
      SunmiCol(text: '???????????? 7%', width: 6),
      SunmiCol(text: '(???????????? 7%)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.row(cols: [
      SunmiCol(text: '???????????????????????????', width: 6),
      SunmiCol(text: '(??????????????????)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.row(cols: [
      SunmiCol(text: '???????????????????????????', width: 6),
      SunmiCol(text: '(Service Chage)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.hr();
    SunmiPrinter.row(cols: [
      SunmiCol(text: '?????????????????????', width: 6),
      SunmiCol(text: '(???????????????????????????????????????????????????)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.row(cols: [
      SunmiCol(text: '?????????????????????:(?????????????????????????????????????????????)', width: 6),
      SunmiCol(text: '(???????????????????????????????????????????????????)', width: 6, align: SunmiAlign.right),
    ]);
    SunmiPrinter.emptyLines(2);
    SunmiPrinter.text(
      '???????????????????????????????????????????????????????????????????????????????????????',
      styles:
          SunmiStyles(size: SunmiSize.md, align: SunmiAlign.center, bold: true),
    );
    SunmiPrinter.text(
      '??????????????????????????????????????????????????????????????????.',
      styles: SunmiStyles(size: SunmiSize.xs, align: SunmiAlign.center),
    );
    SunmiPrinter.hr();
    SunmiPrinter.text(
      '(???????????????????????????????????????????????????????????????)',
      styles:
          SunmiStyles(size: SunmiSize.xs, align: SunmiAlign.center, bold: true),
    );
    SunmiPrinter.text(
      '(?????????????????????????????????????????????)',
      styles:
          SunmiStyles(size: SunmiSize.xs, align: SunmiAlign.center, bold: true),
    );
    SunmiPrinter.text(
      '(????????????????????????????????????)',
      styles:
          SunmiStyles(size: SunmiSize.xs, align: SunmiAlign.center, bold: true),
    );

    // Test imageBarcode
    ByteData bytesbar = await rootBundle.load('assets/images/barcodeAndQR.jpg');
    final bufferbar = bytesbar.buffer;
    final imgDatabar = base64.encode(Uint8List.view(bufferbar));
    SunmiPrinter.image(imgDatabar);

    SunmiPrinter.emptyLines(3);
  }
}
