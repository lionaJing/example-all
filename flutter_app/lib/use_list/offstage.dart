import 'package:flutter/material.dart';

//控制控件是否隐藏显示
//当offstage为true，当前控件不会被绘制在屏幕上，不会响应点击事件，也不会占用空间；
//当offstage为false，当前控件则跟平常用的控件一样渲染绘制；

class OffstagePage extends StatefulWidget {
  @override
  OffstageState createState() => OffstageState();
}

class OffstageState extends State<OffstagePage> {
  bool _visible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Offstage'),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 50.0,
              color: Colors.lime,
            ),
            Offstage(
              offstage: _visible,
              child: Container(
                height: 50.0,
                color: Colors.redAccent,
              ),
            ),
            Container(
              height: 50.0,
              color: Colors.purple,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () {
          setState(() {
            _visible = !_visible;
          });
        },
      ),
    );
  }
}
