import 'package:flutter/material.dart';
import 'package:testprintsunmi/printReceopt/printReceipt.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sunmi printer for V2',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sunmi Printer Test For V2'),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 250.0,
              height: 50.0,
              child: ElevatedButton(
                  onPressed: () async {
                    await printReceipt();
                  },
                  child: Text('PrintReceipt')),
            ),
          ],
        ),
      ),
    );
  }
}
