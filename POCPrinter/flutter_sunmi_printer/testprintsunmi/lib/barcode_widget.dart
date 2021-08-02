import 'dart:convert';
import 'dart:typed_data';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';

class BarcodeWidgetLib extends StatefulWidget {
  BarcodeWidgetLib({Key key}) : super(key: key);

  @override
  _BarcodeWidgetLibState createState() => _BarcodeWidgetLibState();
}

class _BarcodeWidgetLibState extends State<BarcodeWidgetLib> {
  final GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('barcode_widget'),
      ),
      body: Center(
        child: Column(
          children: [
            RepaintBoundary(
              key: globalKey,
              child: BarcodeWidget(
                barcode: Barcode.qrCode(
                  errorCorrectLevel: BarcodeQRCorrectionLevel.high,
                ),
                data: 'https://pub.dev/packages/barcode_widget',
                width: 200,
                height: 200,
              ),
            ),
            RaisedButton(
              onPressed: () async => renderImage(),
              child: const Text('Print barcode_widget',
                  style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> renderImage() async {
    //Get the render object from context.
    final RenderRepaintBoundary boundary =
        globalKey.currentContext.findRenderObject();
    //Convert to the image
    final ui.Image image = await boundary.toImage();
    dynamic bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    final buffer = bytes.buffer;

    final imgData = base64.encode(Uint8List.view(buffer));

    SunmiPrinter.image(imgData);

    SunmiPrinter.emptyLines(3);
  }
}
