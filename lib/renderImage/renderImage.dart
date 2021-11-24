import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'dart:ui' as ui;

import 'package:testprintsunmi/renderImage/setPaperSize.dart';

class ImageRender extends StatefulWidget {
  ImageRender({Key key}) : super(key: key);

  @override
  _ImageRenderState createState() => _ImageRenderState();
}

class _ImageRenderState extends State<ImageRender> {
  @override
  void initState() {
    super.initState();
    connectPrinter();
  }

  connectPrinter() async {
    await SunmiPrinter.bindingPrinter();
  }

  GlobalKey _globalKey = new GlobalKey();

  Uint8List img;

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {
        img = pngBytes;
      });
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black26,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            Transform.translate(
              offset: Offset(0.0, 0.0),
              child: RepaintBoundary(
                key: _globalKey,
                child: Container(
                  //T2
                  //V2 *3 125
                  width: 190,
                  color: Colors.white,
                  child: Column(
                    children: [
                      //*3
                      // height: 70,
                      // width: 100,
                      Container(
                        height: 60,
                        width: 120,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/test111.png'),
                              fit: BoxFit.scaleDown),
                        ),
                      ),
                      Container(
                        child: Text(
                          'TAESHOP',
                          style: TextStyle(
                              fontSize: 22, //12
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          'Saimai 21',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17, //8
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          '121/189 saimai bangkok 10220',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Text(
                            'เบอร์: 064258976',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'วันที่: 23/11/2564',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'รหัสพนักงาน: 1',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'ตำเเหน่ง: admin',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'สินค้า',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'จำนวน',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'ราคา',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'สินค้า1',
                            style: TextStyle(
                                fontSize: dataReceiptSize58,
                                color: Colors.black),
                          ),
                          Text(
                            '1',
                            style: TextStyle(
                                fontSize: dataReceiptSize58,
                                color: Colors.black),
                          ),
                          Text(
                            '200.00',
                            style: TextStyle(
                                fontSize: dataReceiptSize58,
                                color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'สินค้า2',
                            style: TextStyle(
                                fontSize: dataReceiptSize58,
                                color: Colors.black),
                          ),
                          Text(
                            '2',
                            style: TextStyle(
                                fontSize: dataReceiptSize58,
                                color: Colors.black),
                          ),
                          Text(
                            '500.00',
                            style: TextStyle(
                                fontSize: dataReceiptSize58,
                                color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'สินค้า3',
                            style: TextStyle(
                                fontSize: dataReceiptSize58,
                                color: Colors.black),
                          ),
                          Text(
                            '7',
                            style: TextStyle(
                                fontSize: dataReceiptSize58,
                                color: Colors.black),
                          ),
                          Text(
                            '100.00',
                            style: TextStyle(
                                fontSize: dataReceiptSize58,
                                color: Colors.black),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'สินค้า4',
                            style: TextStyle(
                                fontSize: dataReceiptSize58,
                                color: Colors.black),
                          ),
                          Text(
                            '5',
                            style: TextStyle(
                                fontSize: dataReceiptSize58,
                                color: Colors.black),
                          ),
                          Text(
                            '120.00',
                            style: TextStyle(
                                fontSize: dataReceiptSize58,
                                color: Colors.black),
                          )
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 120, //120
                          width: 130, //130
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage('assets/images/QRpayment.jpg'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  await _capturePng();
                },
                child: Text('capturePng')),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  await printReceiptImage(context, img);
                },
                child: Text('printPDF')),
          ],
        )),
      ),
    );
  }

  printReceiptImage(BuildContext context, Uint8List imgByte) async {
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printImage(imgByte);
    await SunmiPrinter.lineWrap(3);
    await SunmiPrinter.getPrinterStatusWithVerbose();
    await SunmiPrinter.cut();
    await SunmiPrinter.exitTransactionPrint(true);
  }
}
