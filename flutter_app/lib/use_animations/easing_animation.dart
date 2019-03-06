import 'package:flutter/material.dart';

//缓动动画

class EasingAnimationPage extends StatefulWidget {
  @override
  EasingAnimationState createState() => EasingAnimationState();
}

// with TickerProviderStateMixin
class EasingAnimationState extends State<EasingAnimationPage>
    with TickerProviderStateMixin {
  //定义变量
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    //初始化构造器
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    //定义补间动画(线性)并通过 CurvedAnimation 更改补间动画的中间值(用非线性取代)
    _animation = Tween(begin: -1.0, end: 0.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn))
      ..addStatusListener(handler);
    _controller.forward();
  }

  void handler(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(handler);
      _controller.stop();
      _controller.reset();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            //Transform 允许在绘制子组件时对其应用一个矩阵转换
            body: Transform(
              transform:
                  Matrix4.translationValues(_animation.value * width, 0.0, 0.0),
              child: Center(
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.deepPurpleAccent,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    //销毁
    _controller.dispose();
  }
}
