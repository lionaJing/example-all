import 'package:flutter/material.dart';
import 'package:flutter_app/routes/screens/about.dart';
import 'package:flutter_app/routes/screens/news.dart';

/// 路由
/// 方式1

class RouteHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new NewsPage(), //根路由 ‘/’
      routes: {
        AboutPage.routeName: (BuildContext context) => new AboutPage(),
      },
    );
  }
}

/// 方式2
//class RouteHomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      ///initialRoute属性定义了应用程序应该从哪个路径开始
//      initialRoute: '/',
//      ///routes属性定义可用的命名路由以及导航到这些路由时应构建的窗口小部件
//      routes: {
//        '/': (context) => new NewsPage(),
//        '/about': (BuildContext context) => new AboutPage()
//      },
//    );
//  }
//}
