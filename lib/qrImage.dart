import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;

class QRImage extends StatefulWidget {
  QRImage({Key key}) : super(key: key);

  @override
  _QRImageState createState() => _QRImageState();
}

class _QRImageState extends State<QRImage> {
  final GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRImageTest'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 100,
              color: Colors.white,
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: "1234567890",
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              ),
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () async => renderImage(),
              child: const Text('Print Qrcode', style: TextStyle(fontSize: 20)),
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
