import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sunmi_printer/flutter_sunmi_printer.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'dart:ui' as ui;

class SfBarcodeGenerators extends StatefulWidget {
  SfBarcodeGenerators({Key key, this.check}) : super(key: key);

  bool check;

  @override
  _SfBarcodeGeneratorsState createState() => _SfBarcodeGeneratorsState();
}

class _SfBarcodeGeneratorsState extends State<SfBarcodeGenerators> {
  final GlobalKey globalKey = GlobalKey();
  bool status;
  @override
  void initState() {
    status = widget.check;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SfBarcodeGeneratorTest'),
      ),
      body: Center(
        child: Column(
          children: [
            status == true
                ? Container(
                    height: 70,
                    color: Colors.white,
                    child: RepaintBoundary(
                      key: globalKey,
                      child: SfBarcodeGenerator(
                        symbology: Code128(),
                        value: 'www.syncfusion.com',
                        showValue: true,
                      ),
                    ),
                  )
                : Container(
                    height: 70,
                    color: Colors.white,
                    child: RepaintBoundary(
                      key: globalKey,
                      child: SfBarcodeGenerator(
                        symbology: QRCode(),
                        value: 'www.syncfusion.com',
                        showValue: true,
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
