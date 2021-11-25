import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:testprintsunmi/renderImage/imgByte.dart';
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
      ui.Image image = await boundary.toImage(pixelRatio: 10);
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
                  width: paperSize58,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: logoImageheightSize58,
                        width: logoImagewidthSize58,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/test111.png'),
                              fit: BoxFit.scaleDown),
                        ),
                      ),
                      Container(
                        child: Text(
                          'TAESHOP',
                          style: textStyleReceipt(businessNameSize58),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        child: Text(
                          'Saimai 21',
                          style: textStyleReceipt(branchNameSize58),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        child: Text(
                          '121/189 saimai bangkok 10220',
                          style: textStyleReceipt(branchAddressSize58),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Text(
                            'เบอร์: 064258976',
                            style: textStyleReceipt(branchPhoneNumberSize58),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'วันที่: 23/11/2564',
                            style: textStyleReceipt(dateSize58),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'รหัสพนักงาน: 1',
                            style: textStyleReceipt(employee_IDSize58),
                          ),
                        ],
                      ),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text('ชื่อสินค้า',
                                style: textStyleReceipt(productNameSize58)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'ราคา',
                              style: textStyleReceipt(priceSize58),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 350,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 70,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text('product$index',
                                      style:
                                          textStyleReceipt(dataReceiptSize58)),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'x$index',
                                    style: textStyleReceipt(dataReceiptSize58),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '$index' + '00',
                                    style: textStyleReceipt(dataReceiptSize58),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              'ยอดรวม:',
                              style: textStyleReceipt(sumtotalSize58),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('600',
                                style: textStyleReceipt(sumtotalSize58),
                                textAlign: TextAlign.end),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              'ภาษี:',
                              style: textStyleReceipt(vatSize58),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('35',
                                style: textStyleReceipt(vatSize58),
                                textAlign: TextAlign.end),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              'ส่วยลด:',
                              style: textStyleReceipt(discountSize58),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('60',
                                style: textStyleReceipt(discountSize58),
                                textAlign: TextAlign.end),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Text(
                              'ราคารวม:',
                              style: TextStyle(
                                fontFamily: 'THSarabunNew',
                                fontWeight: FontWeight.w900,
                                fontSize: totalPriceSize58,
                                decoration: TextDecoration.none,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text('600',
                                style: TextStyle(
                                  fontFamily: 'THSarabunNew',
                                  fontWeight: FontWeight.w900,
                                  fontSize: totalPriceSize58,
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.end),
                          ),
                        ],
                      ),
                      Divider(
                        height: 2,
                        color: Colors.black,
                      ),
                      Container(
                        height: qrcodeImageheightSize58,
                        width: qrcodeImagewidthSize58,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/QRpayment.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
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
            ElevatedButton(
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageLayout(
                              imgByte: img,
                            )),
                  );
                },
                child: Text('Img')),
          ],
        )),
      ),
    );
  }

  printReceiptImage(BuildContext context, Uint8List imgByte) async {
    print(imgByte);
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printImage(imgByte);
    await SunmiPrinter.lineWrap(3);
    await SunmiPrinter.getPrinterStatusWithVerbose();
    await SunmiPrinter.cut();
    await SunmiPrinter.exitTransactionPrint(true);
  }
}
