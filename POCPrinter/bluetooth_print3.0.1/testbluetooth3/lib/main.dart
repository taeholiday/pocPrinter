import 'package:flutter/material.dart';
import 'package:testbluetooth3/home.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test bluetooth_print3.0.1",
      home: Home(),
    );
  }
}
