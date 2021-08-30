import 'dart:typed_data';
import 'package:flutter/material.dart' hide Image;
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'dart:io' show Platform;
import 'package:image/image.dart';

class Print extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  Print(this.data);
  @override
  _PrintState createState() => _PrintState();
}

class _PrintState extends State<Print> {
  PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  String _devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;

  @override
  void initState() {
    if (Platform.isAndroid) {
      //เช็คอุปกรณ์ประเภทandroid
      bluetoothManager.state.listen((val) {
        print('state = $val');
        //valคือสถานะของบูลทูธในอุปกรณ์
        //เช็คว่าfutureว่ายังทำงานอยู่
        if (!mounted) return;
        //val == 12 คือบูลทูธที่อุปกรณ์เปิดอยู่
        if (val == 12) {
          print('on');
          //เริ่มfunctionScanหาอุปกรณ์ปริ้นเตอร์
          initPrinter();
        } else if (val == 10) {
          //val == 10 คือบูลทูธที่อุปกรณ์ปิดอยู่
          print('off');
          setState(() => _devicesMsg = 'Bluetooth Disconnect!');
        }
      });
    } else {
      initPrinter();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Print'),
      ),
      body: _devices.isEmpty //เช็คว่าถ้าข้อมูลอุปกรณ์ที่Scanเจอว่าง
          ? Center(child: Text(_devicesMsg ?? ''))
          : ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                //Listเเสดงอุปกรณ์ที่Scanเจอทั้งหมด
                return ListTile(
                  leading: Icon(Icons.print),
                  title: Text(_devices[index].name),
                  subtitle: Text(_devices[index].address),
                  onTap: () {
                    //เลือกอุปกรณ์ปริ้นเตอร์ที่ต้องการเชื่อม
                    _startPrint(_devices[index]);
                  },
                );
              },
            ),
    );
  }

  void initPrinter() {
    //เริ่มScanหาอุปกรณ์ปริ้นเตอร์เวลา4วิ
    _printerManager.startScan(Duration(seconds: 4));
    _printerManager.scanResults.listen((val) {
      //เช็คว่าfutureว่ายังทำงานอยู่
      if (!mounted) return;
      //valคือชื่อเเละที่อยู่อุปกรณ์ปริ้นเตอร์ที่Scanเจอ
      setState(() => _devices = val);
      // ถ้าหาไม่เจอให้ขึ้นข้อความ No Devices
      if (_devices.isEmpty) setState(() => _devicesMsg = 'No Devices');
    });
  }

  Future<void> _startPrint(PrinterBluetooth printer) async {
    //เริ่มปริ้นรับค่าอุปกรณ์ปริ้นเตอร์ที่เลือกเชื่อมต่อ
    _printerManager.selectPrinter(printer);
    //เริ่มปริ้นส่งformใบเสร็จเข้าFunctionPrintใยเสร็จ
    final result = // ผลลัพธ์ในการปริ้นว่าปริ้นสำเร็จหรือไม่
        await _printerManager.printTicket(await _ticket(PaperSize.mm58));
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        //showผลลัพธ์ในการปริ้น
        content: Text(result.msg),
      ),
    );
  }

  Future<Ticket> _ticket(PaperSize paper) async {
    //Function ใบเสร็จรับค่าขนาดกระดาษ
    final ticket = Ticket(paper);
    int total = 0;

    // Image assets
    final ByteData data = await rootBundle.load('assets/store.png');
    final Uint8List bytes = data.buffer.asUint8List();
    final Image image = decodeImage(bytes);
    ticket.image(image);
    ticket.text(
      'Sunmi TestPrinter',
      styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2),
      linesAfter: 1,
    );

    for (var i = 0; i < widget.data.length; i++) {
      total += widget.data[i]['total_price'];
      ticket.text(widget.data[i]['title']);
      ticket.row([
        PosColumn(
            text: '${widget.data[i]['price']} x ${widget.data[i]['qty']}',
            width: 6),
        PosColumn(text: 'Rp ${widget.data[i]['total_price']}', width: 6),
      ]);
    }

    ticket.feed(1);
    ticket.row([
      PosColumn(text: 'Total', width: 6, styles: PosStyles(bold: true)),
      PosColumn(text: 'Rp $total', width: 6, styles: PosStyles(bold: true)),
    ]);
    ticket.feed(2);
    ticket.text('Thank You',
        styles: PosStyles(align: PosAlign.center, bold: true));
    ticket.cut();

    return ticket;
  }

  @override
  void dispose() {
    //หยุดScanหาแุปกรณ์
    _printerManager.stopScan();
    super.dispose();
  }
}
