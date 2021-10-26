import 'dart:typed_data';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:testprintsunmi/imgToByte.dart';

Future printReceipt() async {
  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
  // Logo
  await SunmiPrinter.initPrinter();
  await SunmiPrinter.startTransactionPrint(true);
  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
  Uint8List byte = await readFileBytes('assets/images/test111.png');
  await SunmiPrinter.printImage(byte);
  await SunmiPrinter.lineWrap(3);

  //receipt

  await SunmiPrinter.line();
  await SunmiPrinter.printText('Payment receipt',
      style: SunmiStyle(align: SunmiPrintAlign.CENTER));
  await SunmiPrinter.printText('Using the old way to bold!',
      style: SunmiStyle(align: SunmiPrintAlign.CENTER));
  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
  await SunmiPrinter.line();

  await SunmiPrinter.printRow(cols: [
    ColumnMaker(text: 'Name', width: 12, align: SunmiPrintAlign.LEFT),
    ColumnMaker(text: 'Qty', width: 6, align: SunmiPrintAlign.CENTER),
    ColumnMaker(text: 'UN', width: 6, align: SunmiPrintAlign.RIGHT),
    ColumnMaker(text: 'TOT', width: 6, align: SunmiPrintAlign.RIGHT),
  ]);

  await SunmiPrinter.printRow(cols: [
    ColumnMaker(text: 'Fries', width: 12, align: SunmiPrintAlign.LEFT),
    ColumnMaker(text: '4x', width: 6, align: SunmiPrintAlign.CENTER),
    ColumnMaker(text: '3.00', width: 6, align: SunmiPrintAlign.RIGHT),
    ColumnMaker(text: '12.00', width: 6, align: SunmiPrintAlign.RIGHT),
  ]);

  await SunmiPrinter.printRow(cols: [
    ColumnMaker(text: 'Strawberry', width: 12, align: SunmiPrintAlign.LEFT),
    ColumnMaker(text: '1x', width: 6, align: SunmiPrintAlign.CENTER),
    ColumnMaker(text: '24.44', width: 6, align: SunmiPrintAlign.RIGHT),
    ColumnMaker(text: '24.44', width: 6, align: SunmiPrintAlign.RIGHT),
  ]);

  await SunmiPrinter.printRow(cols: [
    ColumnMaker(text: 'Soda', width: 12, align: SunmiPrintAlign.LEFT),
    ColumnMaker(text: '1x', width: 6, align: SunmiPrintAlign.CENTER),
    ColumnMaker(text: '1.99', width: 6, align: SunmiPrintAlign.RIGHT),
    ColumnMaker(text: '1.99', width: 6, align: SunmiPrintAlign.RIGHT),
  ]);
  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
  await SunmiPrinter.line();
  await SunmiPrinter.printRow(cols: [
    ColumnMaker(text: 'TOTAL', width: 25, align: SunmiPrintAlign.LEFT),
    ColumnMaker(text: '38.43', width: 6, align: SunmiPrintAlign.RIGHT),
  ]);
  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
  await SunmiPrinter.line();
  await SunmiPrinter.lineWrap(3);
  await SunmiPrinter.exitTransactionPrint(true);
}
