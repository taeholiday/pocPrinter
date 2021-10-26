import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class BarcodeTypeJAN13 extends StatefulWidget {
  BarcodeTypeJAN13({Key key}) : super(key: key);

  @override
  _BarcodeTypeJAN13State createState() => _BarcodeTypeJAN13State();
}

class _BarcodeTypeJAN13State extends State<BarcodeTypeJAN13> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BarcodeType JAN13'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint(true);
                  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
                  await SunmiPrinter.printBarCode('1234567890',
                      barcodeType: SunmiBarcodeType.JAN13,
                      textPosition: SunmiBarcodeTextPos.TEXT_ABOVE,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('JAN13 TEXT_ABOVE'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint(true);
                  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
                  await SunmiPrinter.printBarCode('1234567890',
                      barcodeType: SunmiBarcodeType.JAN13,
                      textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
                      height: 70);

                  await SunmiPrinter.lineWrap(2);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('JAN13 TEXT_UNDER'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint(true);
                  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
                  await SunmiPrinter.printBarCode('1234567890',
                      barcodeType: SunmiBarcodeType.JAN13,
                      textPosition: SunmiBarcodeTextPos.BOTH,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('JAN13 BOTH'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint(true);
                  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
                  await SunmiPrinter.printBarCode('1234567890',
                      barcodeType: SunmiBarcodeType.JAN13,
                      textPosition: SunmiBarcodeTextPos.NO_TEXT,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('JAN13 NO_TEXT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
