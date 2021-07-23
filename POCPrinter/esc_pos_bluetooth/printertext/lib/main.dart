import 'package:flutter/material.dart';
import 'package:printertext/home.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "test Printer",
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
