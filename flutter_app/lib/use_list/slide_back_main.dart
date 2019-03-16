import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// 实现滑动退出
// 只要是 Navigator.of(context).push(CupertinoPageRoute) 的页面都能右滑退出
// 实测： 不够零灵活

class SlideBackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('右滑返回 Demo'),
        ),
        body: Container(
          color: Colors.black26,
          alignment: Alignment(0.0, 0.0),
          child: RaisedButton(
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) => SlideBackPage(),
              ));
            },
            child: Text('我是内容'),
          ),
        ),
      ),
    );
  }
}
