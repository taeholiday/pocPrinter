import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class BarcodeTypeCODE93 extends StatefulWidget {
  BarcodeTypeCODE93({Key key}) : super(key: key);

  @override
  _BarcodeTypeCODE93State createState() => _BarcodeTypeCODE93State();
}

class _BarcodeTypeCODE93State extends State<BarcodeTypeCODE93> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BarcodeType CODE93'),
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
                      barcodeType: SunmiBarcodeType.CODE93,
                      textPosition: SunmiBarcodeTextPos.TEXT_ABOVE,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('CODE93 TEXT_ABOVE'),
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
                      barcodeType: SunmiBarcodeType.CODE93,
                      textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
                      height: 70);

                  await SunmiPrinter.lineWrap(2);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('CODE93 TEXT_UNDER'),
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
                      barcodeType: SunmiBarcodeType.CODE93,
                      textPosition: SunmiBarcodeTextPos.BOTH,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('CODE93 BOTH'),
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
                      barcodeType: SunmiBarcodeType.CODE93,
                      textPosition: SunmiBarcodeTextPos.NO_TEXT,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('CODE93 NO_TEXT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
