import 'dart:io';
import 'dart:convert';
import 'dart:io' as Io;
import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';

class Barcodes extends StatefulWidget {
  Barcodes({Key key}) : super(key: key);

  @override
  _BarcodesState createState() => _BarcodesState();
}

class _BarcodesState extends State<Barcodes> {
  void buildBarcode(
    Barcode bc,
    String data, {
    String filename,
    double width,
    double height,
    double fontHeight,
  }) {
    /// Create the Barcode
    final svg = bc.toSvg(
      data,
      width: width ?? 200,
      height: height ?? 80,
      fontHeight: fontHeight,
    );

    // Save the image
    filename ??= bc.name.replaceAll(RegExp(r'\s'), '-').toLowerCase();
    File('$filename.svg').writeAsStringSync(svg);
  }

  @override
  Widget build(BuildContext context) {
    buildBarcode(
      Barcode.code39(),
      'CODE 39',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode'),
      ),
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
