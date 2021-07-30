import 'package:flutter/material.dart';
import 'package:testprintsunmi/barcode.dart';
import 'package:testprintsunmi/qrImage.dart';

class Routes {
  static String qrImagePage = '/qrImage';
  static String barcodes = '/barcodes';

  static final routes = <String, WidgetBuilder>{
    qrImagePage: (BuildContext context) => QRImage(),
    barcodes: (BuildContext context) => Barcodes()
  };
}
