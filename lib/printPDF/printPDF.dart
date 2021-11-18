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
    var date = DateTime.now().toString().substring(0, 19);
    final imagePng = (await rootBundle.load('assets/images/test111.png'))
        .buffer
        .asUint8List();
    final imageJpg = (await rootBundle.load('assets/images/QRpayment.jpg'))
        .buffer
        .asUint8List();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.roll57,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(children: [
              pw.SizedBox(height: 15),
              pw.Container(
                child: pw.Image(pw.MemoryImage(imagePng)),
              ),
              pw.SizedBox(height: 10),
              pw.Text('Taeshop',
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              pw.Text(
                'First Branch',
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'address',
              ),
              pw.Divider(),
              pw.Row(children: [
                pw.Text(
                  'Tel: 0642589176',
                ),
              ]),
              pw.Row(children: [
                pw.Text(
                  'Date: $date',
                ),
              ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'UserId: 1',
                    ),
                    pw.Text(
                      'Role: oener',
                    ),
                  ]),
              pw.Divider(),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Product Name',
                    ),
                    pw.Text(
                      'Qty',
                    ),
                    pw.Text(
                      'Price',
                    ),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Product1',
                    ),
                    pw.Text(
                      '2',
                    ),
                    pw.Text(
                      '200',
                    ),
                  ]),
              pw.Divider(),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Subtotal',
                    ),
                    pw.Text(
                      '200.00',
                    ),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'VAT',
                    ),
                    pw.Text(
                      '15.00',
                    ),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Discount',
                    ),
                    pw.Text(
                      '10.00',
                    ),
                  ]),
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Total',
                    ),
                    pw.Text(
                      '190.00',
                    ),
                  ]),
              pw.Divider(),
              pw.Container(
                child: pw.Image(pw.MemoryImage(imageJpg)),
              ),
              pw.SizedBox(height: 10),
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
