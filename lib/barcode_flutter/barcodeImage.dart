import 'dart:convert';
import 'dart:typed_data';

import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';
import 'dart:ui' as ui;

class BarcodeImage extends StatefulWidget {
  BarcodeImage({Key key}) : super(key: key);

  @override
  _BarcodeImageState createState() => _BarcodeImageState();
}

class _BarcodeImageState extends State<BarcodeImage> {
  final GlobalKey globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('barcodeImage'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              child: RepaintBoundary(
                key: globalKey,
                child: BarCodeImage(
                  params: Code39BarCodeParams(
                    "1234ABCD",
                    lineWidth:
                        2.0, // width for a single black/white bar (default: 2.0)
                    barHeight:
                        90.0, // height for the entire widget (default: 100.0)
                    withText:
                        true, // Render with text label or not (default: false)
                  ),
                  onError: (error) {
                    // Error handler
                    print('error = $error');
                  },
                ),
              ),
            ),
            SizedBox(height: 30),
            RaisedButton(
              onPressed: () async => renderImage(),
              child: const Text('Print BarcodeImage',
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
