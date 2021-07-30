import 'package:flutter/material.dart';
import 'package:testprintsunmi/barcode.dart';

import 'qr_flutter.dart';

class Routes {
  static String qrImagePage = '/qrImage';
  static String barcodes = '/barcodes';

  static final routes = <String, WidgetBuilder>{
    qrImagePage: (BuildContext context) => QRImage(),
    barcodes: (BuildContext context) => Barcodes()
  };
}
