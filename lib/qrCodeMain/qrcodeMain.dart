import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

class QrcodeMain extends StatefulWidget {
  QrcodeMain({Key key}) : super(key: key);

  @override
  _QrcodeMainState createState() => _QrcodeMainState();
}

class _QrcodeMainState extends State<QrcodeMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QrcodeType'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("QRcodeType"),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint(true);
                  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
                  await SunmiPrinter.printQRCode('https://www.google.co.th/',
                      size: 8);
                  await SunmiPrinter.printText('QRcode LEVEL_H',
                      style: SunmiStyle(fontSize: SunmiFontSize.LG));
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('QRcode LEVEL_H'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint(true);
                  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
                  await SunmiPrinter.printQRCode('https://www.google.co.th/',
                      errorLevel: SunmiQrcodeLevel.LEVEL_L, size: 8);
                  await SunmiPrinter.printText('QRcode LEVEL_L',
                      style: SunmiStyle(fontSize: SunmiFontSize.LG));
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('QRcode LEVEL_L'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint(true);
                  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
                  await SunmiPrinter.printQRCode('https://www.google.co.th/',
                      errorLevel: SunmiQrcodeLevel.LEVEL_M, size: 8);
                  await SunmiPrinter.printText('QRcode LEVEL_M',
                      style: SunmiStyle(fontSize: SunmiFontSize.LG));
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('QRcode LEVEL_M'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () async {
                  await SunmiPrinter.initPrinter();
                  await SunmiPrinter.startTransactionPrint(true);
                  await SunmiPrinter.setAlignment(SunmiPrintAlign.CENTER);
                  await SunmiPrinter.printQRCode('https://www.google.co.th/',
                      errorLevel: SunmiQrcodeLevel.LEVEL_Q, size: 8);
                  await SunmiPrinter.printText('QRcode LEVEL_Q',
                      style: SunmiStyle(fontSize: SunmiFontSize.LG));
                  await SunmiPrinter.lineWrap(5);
                  await SunmiPrinter.exitTransactionPrint(true);
                },
                child: Text('QRcode LEVEL_Q'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
