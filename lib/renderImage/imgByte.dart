import 'dart:typed_data';

import 'package:flutter/material.dart';

class ImageLayout extends StatefulWidget {
  ImageLayout({Key key, this.imgByte}) : super(key: key);

  Uint8List imgByte;

  @override
  _ImageLayoutState createState() => _ImageLayoutState();
}

class _ImageLayoutState extends State<ImageLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ImgByte'),
      ),
      body: Center(
        child: IntrinsicHeight(child: Image.memory(widget.imgByte)),
      ),
    );
  }
}
