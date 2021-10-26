import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class BarcodeTypeITF extends StatefulWidget {
  BarcodeTypeITF({Key key}) : super(key: key);

  @override
  _BarcodeTypeITFState createState() => _BarcodeTypeITFState();
}

class _BarcodeTypeITFState extends State<BarcodeTypeITF> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BarcodeType ITF'),
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
                      barcodeType: SunmiBarcodeType.ITF,
                      textPosition: SunmiBarcodeTextPos.TEXT_ABOVE,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('ITF TEXT_ABOVE'),
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
                      barcodeType: SunmiBarcodeType.ITF,
                      textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
                      height: 70);

                  await SunmiPrinter.lineWrap(2);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('ITF TEXT_UNDER'),
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
                      barcodeType: SunmiBarcodeType.ITF,
                      textPosition: SunmiBarcodeTextPos.BOTH,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('ITF BOTH'),
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
                      barcodeType: SunmiBarcodeType.ITF,
                      textPosition: SunmiBarcodeTextPos.NO_TEXT,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('ITF NO_TEXT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
