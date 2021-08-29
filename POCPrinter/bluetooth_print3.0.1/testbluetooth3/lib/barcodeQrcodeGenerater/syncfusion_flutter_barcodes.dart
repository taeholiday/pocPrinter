import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'dart:ui' as ui;

import 'package:syncfusion_flutter_barcodes/barcodes.dart';

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
          ],
        ),
      ),
    );
  }
}
