import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:native_pdf_renderer/native_pdf_renderer.dart' as pd;
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';

final pdf = pw.Document();

Uint8List pageImagebyte;
createPDE() async {
  final directory = await getApplicationDocumentsDirectory();

  final imageJpg =
      (await rootBundle.load('assets/images/test111.png')).buffer.asUint8List();

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.roll57,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(children: [
            pw.SizedBox(
              height: 100,
              width: 100,
              child: pw.Image(pw.MemoryImage(imageJpg)),
            ),
            pw.Text('miPOS',
                style:
                    pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold)),
            pw.Divider(color: PdfColor(1.0, 1.0, 1.0)),
            pw.Text('name: anukul thongkham'),
            pw.Text('DateTime: 17/11/64 10:30'),
          ]),
        );
      }));

  final file = File("${directory.path}/receipt.pdf");
  await file.writeAsBytes(await pdf.save());
  final document =
      await pd.PdfDocument.openFile("${directory.path}/receipt.pdf");

  final page = await document.getPage(1);
  final pageImage = await page.render(width: page.width, height: page.height);
  await page.close();
  return pageImage.bytes;
}

printPDF() async {
  await SunmiPrinter.initPrinter();
  await SunmiPrinter.printImage(await createPDE());
}
