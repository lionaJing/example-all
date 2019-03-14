import 'package:flutter/material.dart';

// 组件裁剪
// https://segmentfault.com/a/1190000015149101

class ClipRectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('ClipRRect Demo'),
        ),
        body: Container(
          margin: EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: <Widget>[
                ClipRRect(
                  //控制锯齿
                  // hardEdge 有锯齿 速度最快
                  // antiAlias/antiAliasWithSaveLayer 锯齿少(速度慢)
                  clipBehavior: Clip.hardEdge,
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    color: Colors.lime,
                    width: 70,
                    height: 70,
                  ),
                ),
                ClipOval(
                  child: Container(
                    color: Colors.lime,
                    width: 70,
                    height: 70,
                  ),
                ),
                ClipPath(
                  clipper: TriangleClipper(),
                  child: Container(
                    color: Colors.lime,
                    width: 70,
                    height: 70,
                  ),
                ),
                Tooltip(
                  message: 'hi.tool tip.',
                  child: Container(
                    color: Colors.green,
                    width: 100,
                    height: 50,
                    child: Text('请长按我'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
