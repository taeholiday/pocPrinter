import 'dart:async';
import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:testbluetooth3/printFunction.dart';
import 'package:testbluetooth3/testBarcode.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;

  bool _connected = false;
  BluetoothDevice _device;
  String tips = 'no device connect';

  @override
  void initState() {
    super.initState();
    //การเรียกใช้ฟังก์ชั่นเมื่อวิทเจ็ดโหลดเสร็จแล้วreturnfunctionเริ่มScanBluetooth
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initBluetooth() async {
    //เริ่มScanหาbluetoothใช้เวลาScan4วิ
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));
    bool isConnected = await bluetoothPrint.isConnected;
    //เมื่อScanเจอจะawaitส่งค่าboolกลับมา

    bluetoothPrint.state.listen((state) {
      print('cur device status: $state');
      //stateคือสถานะของบูลทูธในอุปกรณ์
      switch (state) {
        //สถานะบูลทูธเปิดอยู่จะเข้าcase connect
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            tips = 'connect success';
          });
          break;
        //สถานะบูลทูธปิดอยู่จะเข้าcase disconnect
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            tips = 'disconnect success';
          });
          break;
        default:
          break;
      }
    });
    //เช็คว่าfutureว่ายังทำงานอยู่
    if (!mounted) return;
    //เช็คว่าถ้าเจออุปกรณ์ให้เซ็ต _connected เป็น true
    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BluetoothPrint example app'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(tips),
                  ),
                ],
              ),
              Divider(),
              StreamBuilder<List<BluetoothDevice>>(
                //ถ้าเชื่อมต่ออุปกรณ์ได้ให้returnlisttileเเสดงที่อยู่เเละชื่ออุปกรณ์
                stream: bluetoothPrint.scanResults,
                initialData: [],
                builder: (context, snapshot) => Column(
                  children: snapshot.data
                      .map((device) => ListTile(
                            //Listเเสดงอุปกรณ์ที่Scanเจอทั้งหมด
                            title: Text(device.name ?? ''),
                            subtitle: Text(device.address),
                            onTap: () async {
                              setState(() {
                                //กดเลือกอุปกรณ์ที่จะเชื่อมต่อเพื่อเชื่อมอุปกรณ์
                                _device = device;
                              });
                            },
                            trailing: _device != null &&
                                    _device.address == device.address
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : null,
                          ))
                      .toList(),
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(
                          child: Text('connect'),
                          //เช็คสถานะอุปกรณ์
                          onPressed: _connected
                              ? null
                              : () async {
                                  if (_device != null &&
                                      _device.address != null) {
                                    //ถ้าจับคู่เจอชื่ออุปกรณ์และที่อยู่แลัวกดconnectอุปกรณ์
                                    await bluetoothPrint.connect(_device);
                                  } else {
                                    setState(() {
                                      tips = 'please select device';
                                    });
                                    print('please select device');
                                  }
                                },
                        ),
                        SizedBox(width: 10.0),
                        OutlinedButton(
                          child: Text('disconnect'),
                          //เช็คสถานะอุปกรณ์
                          onPressed: _connected
                              ? () async {
                                  //กดปุ่มเพื่อยกเลิกการเชื่อมต่อกับอุปกรณ์
                                  await bluetoothPrint.disconnect();
                                }
                              : null,
                        ),
                      ],
                    ),
                    OutlinedButton(
                      child: Text('print receipt(esc)'),
                      //เช็คสถานะอุปกรณ์
                      onPressed: _connected
                          ? () async {
                              //Mapconfigถ้าต้องการเพิ่มการกำหนดขนาดรูปหรือความกว้างกระดาษ
                              Map<String, dynamic> config = Map();
                              //listข้อมูลที่จะปริ้น
                              List<LineText> listReceipt = await printReceipt();
                              //functionปริ้นรับlistข้อมูลที่จะปริ้นกับMap config
                              await bluetoothPrint.printReceipt(
                                  config, listReceipt);
                            }
                          : null,
                    ),
                    OutlinedButton(
                      child: Text('print label(tsc)'),
                      //เช็คสถานะอุปกรณ์
                      onPressed: _connected
                          ? () async {
                              //Mapconfigถ้าต้องการเพิ่มการกำหนดขนาดรูปหรือความกว้างกระดาษ
                              Map<String, dynamic> config = Map();
                              config['width'] = 40;
                              config['height'] = 70;
                              config['gap'] = 2;
                              //listข้อมูลที่จะปริ้น
                              List<LineText> listQRCode = printQRCode();
                              //listข้อมูลที่จะปริ้น
                              List<LineText> listImage = await printImage();
                              //functionปริ้นรับlistข้อมูลที่จะปริ้นกับMap config
                              await bluetoothPrint.printLabel(
                                  config, listQRCode);
                              await bluetoothPrint.printLabel(
                                  config, listImage);
                            }
                          : null,
                    ),
                    OutlinedButton(
                      child: Text('test barcode'),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => TestBarcode()));
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        floatingActionButton: StreamBuilder<bool>(
          stream: bluetoothPrint.isScanning,
          initialData: false,
          builder: (context, snapshot) {
            if (snapshot.data) {
              return FloatingActionButton(
                child: Icon(Icons.stop),
                //ปุ่มเพื่อหยุดScanหาอุปกรณ์
                onPressed: () => bluetoothPrint.stopScan(),
                backgroundColor: Colors.red,
              );
            } else {
              return FloatingActionButton(
                  child: Icon(Icons.search),
                  //ปุ่มเพื่อScanหาอุปกรณ์
                  onPressed: () =>
                      bluetoothPrint.startScan(timeout: Duration(seconds: 4)));
            }
          },
        ),
      ),
    );
  }
}
