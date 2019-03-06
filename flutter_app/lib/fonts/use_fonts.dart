import 'package:flutter/material.dart';
import 'package:flutter_app/fonts/fonts_utils.dart' as utils;

// 自定义字体

class CustomFontsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          title: new Text('自定义字体'),
          leading: new IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: new Container(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: new Text('The quick brown fox jumps over the lazy dog',
                textAlign: TextAlign.center,
                style: utils.getCustomFontTextStyle()),
          ),
        ),
      ),
    );
  }
}
