import 'package:flutter/material.dart';

// AnimatedContainer 动画
// 通过调用 setState() AnimatedContainer 使值呈现线性变化
// 可以变动: 颜色、背景图片、半径、宽、高、形状、阴影、
// 动画的时间由 duration 控制
// curve 属性用于控制曲线效果
//
// AnimatedOpacity 层叠显示消失动画
// AnimatedCrossFade 从一个小部件到另一个小部件的平滑过渡

class AnimatedContainerPage extends StatefulWidget {
  @override
  AnimatedContainerState createState() => AnimatedContainerState();
}

class AnimatedContainerState extends State<AnimatedContainerPage> {
  var color = Colors.blue;
  var height = 100.0;
  var width = 100.0;
  bool firstStateEnabled = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('AnimatedContainer Demo'),
        ),
        body: Container(
          alignment: Alignment(0, -1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
//            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(seconds: 1),
                curve: Curves.easeInBack,
                color: color,
                width: width,
                height: height,
                child: Text('Demo...'),
              ),
              Text('-------'),
              AnimatedCrossFade(
                firstCurve: Curves.easeInBack,
                secondCurve: Curves.easeIn,
                firstChild: Container(
                  color: Colors.red,
                  height: 100.0,
                  width: 100,
                ),
                secondChild: Container(
                  color: Colors.purple,
                  height: 150.0,
                  width: 150.0,
                ),
                crossFadeState: firstStateEnabled
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(milliseconds: 1500),
              ),
              RaisedButton(
                child: Text('AnimatedCrossFade'),
                padding: EdgeInsets.all(8.0),
                onPressed: () {
                  setState(() {
                    firstStateEnabled = !firstStateEnabled;
                  });
                },
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.ac_unit),
          onPressed: () {
            setState(() {
              color = Colors.green;
              height = 150;
              width = 150;
            });
          },
        ),
      ),
    );
  }
}
