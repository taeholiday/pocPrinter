import 'package:flutter/material.dart';
import 'package:testprintsunmi/barcode/barcode.dart';
import 'package:testprintsunmi/barcode_flutter/barcodeImage.dart';
import 'package:testprintsunmi/qr_flutter/qrImage.dart';

class Routes {
  static String qrImagePage = '/qrImage';
  static String barcodes = '/barcodes';
  static String barcodeImage = "/barcodeImage";

  static final routes = <String, WidgetBuilder>{
    qrImagePage: (BuildContext context) => QRImage(),
    barcodes: (BuildContext context) => Barcodes(),
    barcodeImage: (BuildContext context) => BarcodeImage(),
  };
}
