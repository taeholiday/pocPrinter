import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class BarcodeTypeUPCE extends StatefulWidget {
  BarcodeTypeUPCE({Key key}) : super(key: key);

  @override
  _BarcodeTypeUPCEState createState() => _BarcodeTypeUPCEState();
}

class _BarcodeTypeUPCEState extends State<BarcodeTypeUPCE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BarcodeType UPCE'),
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
                      barcodeType: SunmiBarcodeType.UPCE,
                      textPosition: SunmiBarcodeTextPos.TEXT_ABOVE,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('UPCE TEXT_ABOVE'),
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
                      barcodeType: SunmiBarcodeType.UPCE,
                      textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
                      height: 70);

                  await SunmiPrinter.lineWrap(2);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('UPCE TEXT_UNDER'),
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
                      barcodeType: SunmiBarcodeType.UPCE,
                      textPosition: SunmiBarcodeTextPos.BOTH,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('UPCE BOTH'),
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
                      barcodeType: SunmiBarcodeType.UPCE,
                      textPosition: SunmiBarcodeTextPos.NO_TEXT,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('UPCE NO_TEXT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}