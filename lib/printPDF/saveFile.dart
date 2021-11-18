import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/widgets.dart';
import 'package:native_pdf_renderer/native_pdf_renderer.dart' as pd;
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
  final pageImage = await page.render(
      backgroundColor: '#ffffff',
      width: MediaQuery.of(context).size.width.toInt(),
      height: MediaQuery.of(context).size.height.toInt());
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
