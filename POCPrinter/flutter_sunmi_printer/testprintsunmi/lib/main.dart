import 'package:flutter/material.dart';
import 'package:testprintsunmi/home.dart';
import 'package:testprintsunmi/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Sunmi Printer',
      home: Home(),
      debugShowCheckedModeBanner: false,
      routes: Routes.routes,
    );
  }
}
