import 'dart:convert';
import 'dart:typed_data';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/services.dart';

Future<List<LineText>> printImage() async {
  List<LineText> listImage = [];
  ByteData data = await rootBundle.load("assets/images/guide3.png");
  List<int> imageBytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  String base64Image = base64Encode(imageBytes);
  listImage.add(LineText(
    type: LineText.TYPE_IMAGE,
    x: 10,
    y: 10,
    content: base64Image,
  ));
  return listImage;
}

List<LineText> printQRCode() {
  List<LineText> listQRCode = [];
  listQRCode.add(
      LineText(type: LineText.TYPE_TEXT, x: 10, y: 10, content: 'A Title'));
  listQRCode.add(LineText(
      type: LineText.TYPE_TEXT, x: 10, y: 40, content: 'this is content'));
  listQRCode.add(LineText(
      type: LineText.TYPE_QRCODE, x: 10, y: 70, content: 'qrcode i\n'));
  listQRCode.add(LineText(
      type: LineText.TYPE_BARCODE, x: 10, y: 190, content: 'qrcode i\n'));
  return listQRCode;
}

Future<List<LineText>> printReceipt() async {
  List<LineText> listReceipt = [];
  listReceipt.add(LineText(
      type: LineText.TYPE_TEXT,
      content: '(Business Name)',
      size: 15,
      weight: 1,
      align: LineText.ALIGN_CENTER,
      linefeed: 1));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    size: 10,
    content: '(Business Caption)',
    weight: 1,
    align: LineText.ALIGN_CENTER,
  ));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    size: 10,
    content: '(Name and Modifiers)',
    weight: 4,
    align: LineText.ALIGN_LEFT,
  ));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    size: 10,
    content: '(Qty)',
    weight: 4,
    align: LineText.ALIGN_CENTER,
  ));
  listReceipt.add(LineText(
      type: LineText.TYPE_TEXT,
      content: '(Line Total)',
      weight: 4,
      align: LineText.ALIGN_RIGHT,
      linefeed: 1));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: 'SUBTOTAL',
    weight: 6,
    align: LineText.ALIGN_LEFT,
  ));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: '(subtotal)',
    weight: 6,
    align: LineText.ALIGN_RIGHT,
  ));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: 'VAT',
    weight: 6,
    align: LineText.ALIGN_LEFT,
  ));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: '(Tax)',
    weight: 6,
    align: LineText.ALIGN_RIGHT,
  ));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: 'TOTAL DICOUNT',
    weight: 6,
    align: LineText.ALIGN_LEFT,
  ));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: '(Discount)',
    weight: 6,
    align: LineText.ALIGN_RIGHT,
  ));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: 'SERVICE CHAGE',
    weight: 6,
    align: LineText.ALIGN_LEFT,
  ));
  listReceipt.add(LineText(
      type: LineText.TYPE_TEXT,
      content: '(Service Chage)',
      weight: 6,
      align: LineText.ALIGN_RIGHT,
      linefeed: 1));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: 'TOTAL',
    weight: 6,
    align: LineText.ALIGN_RIGHT,
  ));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: '(Total Invoice)',
    weight: 6,
    align: LineText.ALIGN_LEFT,
  ));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: 'PAID BY:(Payment Titles)',
    weight: 6,
    align: LineText.ALIGN_RIGHT,
  ));
  listReceipt.add(LineText(
      type: LineText.TYPE_TEXT,
      content: '(Payment Values)',
      weight: 6,
      align: LineText.ALIGN_LEFT,
      linefeed: 2));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: 'Thank You For Your Visit',
    size: 15,
    weight: 1,
    align: LineText.ALIGN_CENTER,
  ));
  listReceipt.add(LineText(
      type: LineText.TYPE_TEXT,
      content: 'Please keep for your record.',
      size: 10,
      weight: 1,
      align: LineText.ALIGN_CENTER,
      linefeed: 1));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: '(Business Address)',
    size: 10,
    weight: 1,
    align: LineText.ALIGN_CENTER,
  ));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: '(Business Website)',
    size: 10,
    weight: 1,
    align: LineText.ALIGN_CENTER,
  ));
  listReceipt.add(LineText(
    type: LineText.TYPE_TEXT,
    content: '(Business Email)',
    size: 10,
    weight: 1,
    align: LineText.ALIGN_CENTER,
  ));

  listReceipt.add(LineText(linefeed: 1));
  return listReceipt;
}
