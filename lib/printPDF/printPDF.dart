import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sunmi_printer_plus/sunmi_printer_plus.dart';
import 'package:testprintsunmi/printPDF/saveFile.dart';

class PDF extends StatefulWidget {
  PDF({Key key}) : super(key: key);

  @override
  _PDFState createState() => _PDFState();
}

class _PDFState extends State<PDF> {
  final pdf = pw.Document();

  Uint8List pageImagebyte;
  @override
  void initState() {
    super.initState();
    createPDE();
  }

  openPdfFile(BuildContext context) async {
    pageImagebyte = await openPdfFileAndConvertImage(context);
  }

  @override
  Widget build(BuildContext context) {
    openPdfFile(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.memory(pageImagebyte),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 250,
                child: ElevatedButton(
                    onPressed: () async {
                      await printPDF();
                    },
                    child: Text('print')),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  createPDE() async {
    final imageJpg = (await rootBundle.load('assets/images/test111.png'))
        .buffer
        .asUint8List();

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
              pw.Text('Taeshop',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.Divider(),
              pw.Text('name: anukul thongkham'),
              pw.Text('DateTime: 17/11/64 10:30'),
            ]),
          );
        }));

    await writeData(await pdf.save());
  }

  printPDF() async {
    print(pageImagebyte);
    await SunmiPrinter.initPrinter();
    await SunmiPrinter.startTransactionPrint(true);
    await SunmiPrinter.printImage(pageImagebyte);
    await SunmiPrinter.lineWrap(3);
    await SunmiPrinter.getPrinterStatusWithVerbose();
    await SunmiPrinter.cut();
    await SunmiPrinter.exitTransactionPrint(true);
  }
}
