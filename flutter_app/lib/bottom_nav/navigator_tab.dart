import 'package:flutter/material.dart';
import 'package:flutter_app/bottom_nav/tab/first.dart';
import 'package:flutter_app/bottom_nav/tab/second.dart';
import 'package:flutter_app/bottom_nav/tab/third.dart';

// 底部导航
// 同样可以添加到顶部导航 https://www.jianshu.com/p/78c5d647c6e0

class NavigatorTabBottomHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new TabHomePage(),
    );
  }
}

class TabHomePage extends StatefulWidget {
  @override
  TabHomeState createState() => new TabHomeState();
}

class TabHomeState extends State<TabHomePage>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('底部导航栏'),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: new TabBarView(
        children: <Widget>[new FirstTab(), new SecondTab(), new ThirdTab()],
        controller: tabController,
      ),
      bottomNavigationBar: new Material(
        color: Colors.blue,
        child: new TabBar(
          controller: tabController,
          //标签颜色
          labelColor: Colors.orange,
          //未被选中的标签的颜色
          unselectedLabelColor: Colors.white,
          // 被选中的那个区域(注释后底部显示横条)
          indicator: BoxDecoration(color: Colors.deepPurpleAccent),
          tabs: <Tab>[
            new Tab(
              icon: new Icon(Icons.favorite),
              text: '喜欢',
            ),
            new Tab(
              icon: new Icon(Icons.adb),
              text: '天河',
            ),
            new Tab(
              icon: new Icon(Icons.airport_shuttle),
              text: '某一',
            ),
          ],
        ),
      ),
    );
  }
}
