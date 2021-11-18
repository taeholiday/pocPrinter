import 'dart:typed_data';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:testprintsunmi/constant/setPaperSize.dart';
import 'package:testprintsunmi/imgToByte.dart';

Future printReceipt(int value) async {
  // Logo
  await SunmiPrinter.initPrinter();
  await SunmiPrinter.startTransactionPrint(true);
  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
  Uint8List byte = await readFileBytes('assets/images/test111.png');
  await SunmiPrinter.printImage(byte);
  await SunmiPrinter.lineWrap(3);

  //receipt detail

  await SunmiPrinter.line(len: value == 1 ? 31 : 96);
  await SunmiPrinter.printText('Payment receipt',
      style: SunmiStyle(align: SunmiPrintAlign.CENTER));
  await SunmiPrinter.printText('Using the old way to bold!',
      style: SunmiStyle(align: SunmiPrintAlign.CENTER));
  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
  await SunmiPrinter.line(len: value == 1 ? 31 : 96);

  await SunmiPrinter.printRow(cols: [
    ColumnMaker(
        text: 'Name',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductNamePaper58
            : PaperSizeForSunmiPrinter.widthForProductNamePaper80,
        align: SunmiPrintAlign.LEFT),
    ColumnMaker(
        text: 'Qty',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductAmountPaper58
            : PaperSizeForSunmiPrinter.widthForProductAmountPaper80,
        align: SunmiPrintAlign.CENTER),
    ColumnMaker(
        text: 'UN',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductSalePricePaper58
            : PaperSizeForSunmiPrinter.widthForProductSalePricePaper80,
        align: SunmiPrintAlign.RIGHT),
    ColumnMaker(
        text: 'TOT',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductTotalPricePaper58
            : PaperSizeForSunmiPrinter.widthForProductTotalPricePaper80,
        align: SunmiPrintAlign.RIGHT),
  ]);

  await SunmiPrinter.printRow(cols: [
    ColumnMaker(
        text: 'Fries',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductNamePaper58
            : PaperSizeForSunmiPrinter.widthForProductNamePaper80,
        align: SunmiPrintAlign.LEFT),
    ColumnMaker(
        text: '100x',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductAmountPaper58
            : PaperSizeForSunmiPrinter.widthForProductAmountPaper80,
        align: SunmiPrintAlign.CENTER),
    ColumnMaker(
        text: '100000.00',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductSalePricePaper58
            : PaperSizeForSunmiPrinter.widthForProductSalePricePaper80,
        align: SunmiPrintAlign.RIGHT),
    ColumnMaker(text: '100000.00', width: 9, align: SunmiPrintAlign.RIGHT),
  ]);

  await SunmiPrinter.printRow(cols: [
    ColumnMaker(
        text: 'Strawberry',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductNamePaper58
            : PaperSizeForSunmiPrinter.widthForProductNamePaper80,
        align: SunmiPrintAlign.LEFT),
    ColumnMaker(
        text: '100x',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductAmountPaper58
            : PaperSizeForSunmiPrinter.widthForProductAmountPaper80,
        align: SunmiPrintAlign.CENTER),
    ColumnMaker(
        text: '100000.00',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductSalePricePaper58
            : PaperSizeForSunmiPrinter.widthForProductSalePricePaper80,
        align: SunmiPrintAlign.RIGHT),
    ColumnMaker(
        text: '100000.00',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductTotalPricePaper58
            : PaperSizeForSunmiPrinter.widthForProductTotalPricePaper80,
        align: SunmiPrintAlign.RIGHT),
  ]);

  await SunmiPrinter.printRow(cols: [
    ColumnMaker(
        text: 'Soda',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductNamePaper58
            : PaperSizeForSunmiPrinter.widthForProductNamePaper80,
        align: SunmiPrintAlign.LEFT),
    ColumnMaker(
        text: '100x',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductAmountPaper58
            : PaperSizeForSunmiPrinter.widthForProductAmountPaper80,
        align: SunmiPrintAlign.CENTER),
    ColumnMaker(
        text: '100000.00',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductSalePricePaper58
            : PaperSizeForSunmiPrinter.widthForProductSalePricePaper80,
        align: SunmiPrintAlign.RIGHT),
    ColumnMaker(
        text: '100000.00',
        width: value == 1
            ? PaperSizeForSunmiPrinter.widthForProductTotalPricePaper58
            : PaperSizeForSunmiPrinter.widthForProductTotalPricePaper80,
        align: SunmiPrintAlign.RIGHT),
  ]);
  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
  await SunmiPrinter.line(len: value == 1 ? 31 : 96);
  await SunmiPrinter.printRow(cols: [
    ColumnMaker(text: 'TOTAL', width: 25, align: SunmiPrintAlign.LEFT),
    ColumnMaker(text: '300000.43', width: 21, align: SunmiPrintAlign.RIGHT),
  ]);
  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
  await SunmiPrinter.line(len: value == 1 ? 31 : 96);
  await SunmiPrinter.lineWrap(3);
  await SunmiPrinter.getPrinterStatusWithVerbose();
  await SunmiPrinter.cut();
  await SunmiPrinter.exitTransactionPrint(true);
}
