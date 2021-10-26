import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

Future printReceipt() async {
  /// must binding ur printer at first init in app
  Future<bool> _bindingPrinter() async {
    final bool result = await SunmiPrinter.bindingPrinter();
    return result;
  }

  // ImageTobyte
  Future<Uint8List> readFileBytes(String path) async {
    ByteData fileData = await rootBundle.load(path);
    Uint8List fileUnit8List = fileData.buffer
        .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
    return fileUnit8List;
  }

  if (await _bindingPrinter() == true) {
    // img
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    Uint8List byte = await readFileBytes('assets/images/test111.png');
    await SunmiPrinter.printImage(byte);
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.lineWrap(3);

    //receipt
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.line();
    await SunmiPrinter.printText('Payment receipt');
    await SunmiPrinter.printText('Using the old way to bold!');
    await SunmiPrinter.line();

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'Name', width: 66, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: 'Qty', width: 6, align: SunmiPrintAlign.CENTER),
      ColumnMaker(text: 'UN', width: 6, align: SunmiPrintAlign.RIGHT),
      ColumnMaker(text: 'TOT', width: 6, align: SunmiPrintAlign.RIGHT),
      ColumnMaker(text: 'TAE', width: 6, align: SunmiPrintAlign.RIGHT),
    ]);

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'Fries', width: 6, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '4x', width: 6, align: SunmiPrintAlign.CENTER),
      ColumnMaker(text: '3.00', width: 6, align: SunmiPrintAlign.RIGHT),
      ColumnMaker(text: '12.00', width: 6, align: SunmiPrintAlign.RIGHT),
      ColumnMaker(text: '12.00', width: 6, align: SunmiPrintAlign.RIGHT),
      ColumnMaker(text: '12.00', width: 6, align: SunmiPrintAlign.RIGHT),
    ]);

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'Strawberry', width: 6, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '1x', width: 6, align: SunmiPrintAlign.CENTER),
      ColumnMaker(text: '24.44', width: 6, align: SunmiPrintAlign.RIGHT),
      ColumnMaker(text: '24.44', width: 6, align: SunmiPrintAlign.RIGHT),
      ColumnMaker(text: '24.44', width: 6, align: SunmiPrintAlign.RIGHT),
    ]);

    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'Soda', width: 6, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '1x', width: 6, align: SunmiPrintAlign.CENTER),
      ColumnMaker(text: '1.99', width: 6, align: SunmiPrintAlign.RIGHT),
      ColumnMaker(text: '1.99', width: 6, align: SunmiPrintAlign.RIGHT),
      ColumnMaker(text: '1.99', width: 6, align: SunmiPrintAlign.RIGHT),
    ]);

    await SunmiPrinter.line();
    await SunmiPrinter.printRow(cols: [
      ColumnMaker(text: 'TOTAL', width: 25, align: SunmiPrintAlign.LEFT),
      ColumnMaker(text: '38.43', width: 6, align: SunmiPrintAlign.RIGHT),
    ]);

    //printLine
    await SunmiPrinter.line();

    //barcode
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.printBarCode('1234567890',
        barcodeType: SunmiBarcodeType.CODE128,
        textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
        height: 70);
    await SunmiPrinter.lineWrap(2);
    //QRcode
    await SunmiPrinter.printQRCode('https://www.google.co.th/');
    await SunmiPrinter.lineWrap(5);
    await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
    await SunmiPrinter.submitTransactionPrint();
    await SunmiPrinter.cut();
    await SunmiPrinter.exitTransactionPrint(true);
  }
}
