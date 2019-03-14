import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/json/user.dart';

// 加载 json
// 分为好几种情况
// https://medium.com/flutter-community/parsing-complex-json-in-flutter-747c46655f51

class JsonPage extends StatefulWidget {
  @override
  JsonPageState createState() => new JsonPageState();
}

class JsonPageState extends State<JsonPage> {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          title: new Text("JSON Example"),
          leading: new IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: new Container(
          padding: const EdgeInsets.all(16),
          child: new Center(
            child: buildFutureBuilder(context),
          ),
        ),
      ),
    );
  }

  FutureBuilder buildFutureBuilder(BuildContext context) {
    return new FutureBuilder<String>(
      builder: (context, async) {
        if (async.connectionState == ConnectionState.none) {
          // 未执行
          return new Text("未执行");
        }
        if (async.connectionState == ConnectionState.waiting) {
          // 正在执行
          return new Text("正在执行");
        }
        if (async.connectionState == ConnectionState.active) {
          // 连接到一个活跃的操作,不断获取值
          return new Text("active");
        }
        if (async.connectionState == ConnectionState.done) {
          // 执行结束
          var user = new User.fromJson(jsonDecode(async.data));
          return new Text(user.name+" & "+user.email);
        }
      },

      ///异步代码块
      future:getData(),
    );
  }

  Future<String> getData() {
    return Future(() => jsonEncode(User("jack", "15576773@163.com")));
  }
}
