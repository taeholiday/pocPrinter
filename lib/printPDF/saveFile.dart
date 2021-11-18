import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart' as pd;
import 'package:native_pdf_renderer/native_pdf_renderer.dart';
import 'package:path_provider/path_provider.dart';

String pathString;

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  pathString = "$path/receipt.pdf";
  return File("$path/receipt.pdf");
}

Future<File> writeData(Uint8List savePDF) async {
  final file = await _localFile;

  // Write the file
  return file.writeAsBytes(savePDF);
}

Future openPdfFileAndConvertImage(BuildContext context) async {
  final document = await pd.PdfDocument.openFile(pathString);
  final page = await document.getPage(1);
  print(page.width);
  print(page.height);
  final pageImage = await page.render(
    backgroundColor: '#ffffff',
    format: PdfPageFormat.PNG,
    width: (page.width * 2.8).toInt(), // 161 * 2.8
    height: page.height * 3, // 478 * 3
    cropRect: Rect.fromLTRB(
        30, 0, (page.width * 2.8).toDouble(), (page.height * 3).toDouble()),
  );
  await page.close();
  if (pageImage.bytes != null) {
    return pageImage.bytes;
  }
}

Future deleteFile() async {
  final file = await _localFile;
  if (file != null) {
    await file.delete();
  }
}
