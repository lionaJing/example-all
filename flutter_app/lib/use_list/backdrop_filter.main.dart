import 'dart:ui';

import 'package:flutter/material.dart';

//BackdropFilter + ImageFilter
//实现滤镜的效果(背景模糊、滤镜等)

class BackdropFilterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('背景滤镜'),
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: Center(
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                _imgWidget(),
                _imgPartWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //图片全部高斯模糊
  Widget _imgWidget() {
    String url =
        'https://tse3.mm.bing.net/th?id=OIP.CREXUbkxGDZ39n5DesDNkQHaE8&pid=Api';
    return Container(
      width: 300,
      height: 200,
      child: Stack(
        // 指定子项的大小
        // StackFit.loose 松散
        // StackFit.expand 收紧
        fit: StackFit.expand,
        // 是否应该剪掉溢出的部分
        // Overflow.clip 裁剪
        overflow: Overflow.clip,
        children: <Widget>[
          Image.network(
            url,
            fit: BoxFit.cover,
            height: 200,
            width: 300,
          ),
          BackdropFilter(
            //高斯模糊
            filter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Container(
              color: Colors.black26,
            ),
          )
        ],
      ),
    );
  }

  //模糊部分图像
  Widget _imgPartWidget() {
    String url =
        'https://tse3.mm.bing.net/th?id=OIP.CREXUbkxGDZ39n5DesDNkQHaE8&pid=Api';
    return Container(
      width: 300,
      height: 200,
      child: Stack(
        fit: StackFit.expand,
        overflow: Overflow.clip,
        children: <Widget>[
          Image.network(
            url,
            fit: BoxFit.cover,
            height: 200,
            width: 300,
          ),
          // Positioned 内部定位组件放置位置
          // Positioned.fill() 填充父组件空间
          Positioned(
            top: 50,
            bottom: 80,
            left: 100,
            right: 150,
            child: BackdropFilter(
              //高斯模糊
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
              ),
              child: Container(
                color: Colors.black26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
