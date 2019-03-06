import 'package:flutter/material.dart';

///路由-关于页面

class AboutPage extends StatelessWidget {
  static const String routeName = "/about";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("关于"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Center(
            child: RaisedButton(
                child: Text("独家新闻"),
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                })),
      ),
    );
  }
}
