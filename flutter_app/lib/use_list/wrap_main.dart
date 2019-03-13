import 'package:flutter/material.dart';

// Wrap

class WrapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Wrap Demo'),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text('Wrap 可以理解为自适应布局,当内容超出屏幕时,可以使用 wrap '
                  '包裹,当空间不足时它会自动新增一行(direction 用于控制 wrap'
                  '方向)'),
              Wrap(
                direction: Axis.vertical,
                children: <Widget>[
                  Container(color: Colors.red, height: 50.0,width: 50.0),
                  Container(color: Colors.purple, height: 50.0,width: 50.0),
                  Container(color: Colors.green, height: 50.0,width: 50.0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
