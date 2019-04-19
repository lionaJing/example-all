import 'package:flutter/material.dart';
// 将子项调整为特定宽高比的小部件

class AspectRatioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('AspectRatio Demo'),
        ),
        body: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Text(''),
                color: Colors.purple,
              ),
              Expanded(
                child: Container(
                  child: Text('Flexible与Expanded相反'),
                  color: Colors.lightGreen,
                ),
              ),
              Container(
                child: Text(''),
                color: Colors.purple,
              ),
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  child: Text('AspectRatio 适用于固定宽高比情景'),
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemWidget1() {
    return Container(
      child: Text('------------------------------'),
    );
  }

  Widget _itemWidget2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Text('111111'),
        ),
        Expanded(
          child: Text('加宽度是为了证明,Expanded不受这个宽度约束,强制子组件填充可用空间'),
        ),
      ],
    );
  }
}
