import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class BarcodetypeUPCA extends StatefulWidget {
  BarcodetypeUPCA({Key key}) : super(key: key);

  @override
  _BarcodetypeUPCAState createState() => _BarcodetypeUPCAState();
}

class _BarcodetypeUPCAState extends State<BarcodetypeUPCA> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BarcodeType UPCA'),
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
                      barcodeType: SunmiBarcodeType.UPCA,
                      textPosition: SunmiBarcodeTextPos.TEXT_ABOVE,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('UPCA TEXT_ABOVE'),
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
                      barcodeType: SunmiBarcodeType.UPCA,
                      textPosition: SunmiBarcodeTextPos.TEXT_UNDER,
                      height: 70);

                  await SunmiPrinter.lineWrap(2);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('UPCA TEXT_UNDER'),
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
                      barcodeType: SunmiBarcodeType.UPCA,
                      textPosition: SunmiBarcodeTextPos.BOTH,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('UPCA BOTH'),
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
                      barcodeType: SunmiBarcodeType.UPCA,
                      textPosition: SunmiBarcodeTextPos.NO_TEXT,
                      height: 70);
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('UPCA NO_TEXT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
