import 'package:flutter/material.dart';

// AnimatedContainer 动画
// 通过调用 setState() AnimatedContainer 使值呈现线性变化
// 可以变动: 颜色、背景图片、半径、宽、高、形状、阴影、
// 动画的时间由 duration 控制
// curve 属性用于控制曲线效果
//

class AnimatedContainerPage extends StatefulWidget {
  @override
  AnimatedContainerState createState() => AnimatedContainerState();
}

class AnimatedContainerState extends State<AnimatedContainerPage> {
  var color = Colors.blue;
  var height = 100.0;
  var width = 100.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('AnimatedContainer Demo'),
        ),
        body: Container(
          child: Center(
            child: AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInBack,
              color: color,
              width: width,
              height: height,
              child: Text('Demo...')
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.ac_unit),
          onPressed: () {
            setState(() {
              color = Colors.green;
              height = 300;
              width = 300;
            });
          },
        ),
      ),
    );
  }
}
