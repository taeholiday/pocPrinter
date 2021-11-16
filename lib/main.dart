import 'package:flutter/material.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:testprintsunmi/barcodeMain/barcodeMain.dart';
import 'package:testprintsunmi/customESC/customReceipt.dart';
import 'package:testprintsunmi/printPDF/printPDF.dart';
import 'package:testprintsunmi/printReceopt/printReceipt.dart';
import 'package:testprintsunmi/qrCodeMain/qrcodeMain.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sunmi printer for V2',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int paperSize = 0;
  String serialNumber = "";
  String printerVersion = "";
  bool printBinded = false;
  int selectPaperSize = 1;
  setDataPrinter() async {
    await SunmiPrinter.paperSize().then((int size) async {
      setState(() {
        paperSize = size;
      });
    });

    await SunmiPrinter.printerVersion().then((String version) async {
      setState(() {
        printerVersion = version;
      });
    });

    await SunmiPrinter.serialNumber().then((String serial) async {
      setState(() {
        serialNumber = serial;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sunmi Printer Test For V2'),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 250.0,
                      height: 50.0,
                      child: ElevatedButton(
                          onPressed: () async {
                            await SunmiPrinter.bindingPrinter();
                            setState(() {
                              printBinded = true;
                              setDataPrinter();
                            });
                          },
                          child: Text('connect Printer')),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 250.0,
                      height: 50.0,
                      child: ElevatedButton(
                          onPressed: () async {
                            await SunmiPrinter.unbindingPrinter();
                            setState(() {
                              printBinded = false;
                            });
                          },
                          child: Text('disconnect Printer')),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
              ),
              child: Text("Print binded: " + printBinded.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text("Paper size: " + paperSize.toString()),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text("Serial number: " + serialNumber),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Text("Printer version: " + printerVersion),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Set papersize'),
                Radio(
                  value: 1,
                  groupValue: selectPaperSize,
                  onChanged: (value) {
                    setState(() {
                      selectPaperSize = value;
                    });
                  },
                ),
                Text("58 mm."),
                Radio(
                  value: 2,
                  groupValue: selectPaperSize,
                  onChanged: (value) {
                    setState(() {
                      selectPaperSize = value;
                    });
                  },
                ),
                Text("80 mm."),
              ],
            ),
            const Divider(),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                  onPressed: () async {
                    printBinded == true
                        ? await printReceipt(selectPaperSize)
                        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.grey[850],
                            content: Row(
                              children: [
                                Text('Disconnect printer'),
                              ],
                            ),
                          ));
                  },
                  child: Text('PrintReceipt')),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                  onPressed: () async {
                    printBinded == true
                        ? await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomReceipt(
                                      selectPaperSize: selectPaperSize,
                                    )),
                          )
                        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.grey[850],
                            content: Row(
                              children: [
                                Text('Disconnect printer'),
                              ],
                            ),
                          ));
                  },
                  child: Text('Custom ESC/POS to print')),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                  onPressed: () async {
                    printBinded == true
                        ? await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BarcodeMain()),
                          )
                        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.grey[850],
                            content: Row(
                              children: [
                                Text('Disconnect printer'),
                              ],
                            ),
                          ));
                  },
                  child: Text('PrintBarcode')),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                  onPressed: () async {
                    printBinded == true
                        ? await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => QrcodeMain()),
                          )
                        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.grey[850],
                            content: Row(
                              children: [
                                Text('Disconnect printer'),
                              ],
                            ),
                          ));
                  },
                  child: Text('PrintQRcode')),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                  onPressed: () async {
                    printBinded == true
                        ? await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PdfLayout()),
                          )
                        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.grey[850],
                            content: Row(
                              children: [
                                Text('Disconnect printer'),
                              ],
                            ),
                          ));
                  },
                  child: Text('Cut_paper')),
            ),
          ],
        ),
      ),
    );
  }
}
