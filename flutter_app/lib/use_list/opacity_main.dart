import 'package:flutter/material.dart';

// 当控制一个控件隐藏但是想让这个控件的位置依然保留(类似 invisible)
// 则可以使用 Opacity 当前控件,设置 opacity: 0.0 即可
//
// 如果用 Opacity 将一个子部件与另外一个子部件层叠在一起(或者创建一个动态的 Opacity)
// 可以使用 AnimatedOpacity

class OpacityPage extends StatefulWidget {
  @override
  OpacityState createState() => OpacityState();
}

class OpacityState extends State<OpacityPage> {
  var myOpacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Opacity Demo'),
        ),
        body: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(color: Colors.red, height: 50.0),
                Opacity(
                  opacity: 0.0,
                  child: Container(color: Colors.purple, height: 50.0),
                ),
                Container(color: Colors.green, height: 50.0),
                Text('-------'),
                Stack(
                  children: <Widget>[
                    Container(color: Colors.lime, height: 150.0, width: 150),
                    AnimatedOpacity(
                      duration: Duration(seconds: 1),
                      opacity: myOpacity,
                      child: Container(
                          color: Colors.black26, height: 150.0, width: 150),
                    ),
                  ],
                ),
                Text('-------'),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.accessibility),
          onPressed: () {
            setState(() {
              myOpacity = 0.0;
            });
          },
        ),
      ),
    );
  }
}
