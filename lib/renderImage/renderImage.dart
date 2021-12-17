import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:testprintsunmi/renderImage/imgByte.dart';
import 'dart:ui' as ui;

import 'package:testprintsunmi/renderImage/setPaperSize.dart';

class ImageRender extends StatefulWidget {
  ImageRender({Key key, this.selectPaperSize}) : super(key: key);
  final int selectPaperSize;
  @override
  _ImageRenderState createState() => _ImageRenderState();
}

class _ImageRenderState extends State<ImageRender> {
  int val = 1;
  @override
  void initState() {
    super.initState();
    connectPrinter();
    val = widget.selectPaperSize;
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
                  width: val == 1 ? paperSize58 : paperSize90,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: val == 1
                            ? logoImageheightSize58
                            : logoImageheightSize90,
                        width: val == 1
                            ? logoImagewidthSize58
                            : logoImagewidthSize90,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/test111.png'),
                              fit: BoxFit.scaleDown),
                        ),
                      ),
                      Container(
                        child: Text(
                          'TAESHOP',
                          style: textStyleReceipt(val == 1
                              ? businessNameSize58
                              : businessNameSize90),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        child: Text(
                          'Saimai 21',
                          style: textStyleReceipt(
                              val == 1 ? branchNameSize58 : branchNameSize90),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        child: Text(
                          '121/189 saimai bangkok 10220',
                          style: textStyleReceipt(val == 1
                              ? branchAddressSize58
                              : branchAddressSize90),
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
                            style: textStyleReceipt(val == 1
                                ? branchPhoneNumberSize58
                                : branchPhoneNumberSize90),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'วันที่: 23/11/2564',
                            style: textStyleReceipt(
                                val == 1 ? dateSize58 : dateSize90),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'รหัสพนักงาน: 1',
                            style: textStyleReceipt(val == 1
                                ? employee_IDSize58
                                : employee_IDSize90),
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
                                style: textStyleReceipt(val == 1
                                    ? productNameSize58
                                    : productNameSize90)),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'ราคา',
                              style: textStyleReceipt(
                                  val == 1 ? priceSize58 : priceSize90),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 350,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 5,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text('product$index',
                                      style: textStyleReceipt(val == 1
                                          ? dataReceiptSize58
                                          : dataReceiptSize90)),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'x$index',
                                    style: textStyleReceipt(val == 1
                                        ? dataReceiptSize58
                                        : dataReceiptSize90),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '$index' + '00',
                                    style: textStyleReceipt(val == 1
                                        ? dataReceiptSize58
                                        : dataReceiptSize90),
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
                      SizedBox(
                        height: 3,
                      ),
                      Container(
                        height: val == 1
                            ? qrcodeImageheightSize58
                            : qrcodeImageheightSize90,
                        width: val == 1
                            ? qrcodeImagewidthSize58
                            : qrcodeImagewidthSize90,
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
