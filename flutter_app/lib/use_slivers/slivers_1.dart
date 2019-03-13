import 'package:flutter/material.dart';

//滚动视图嵌套滑动效果

class SliverAppBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // 是不是也可以换成 NestedScrollView ？
        body: CustomScrollView(
          slivers: <Widget>[
            // SliverAppBar 可以跟随内容滚动
            SliverAppBar(
               //是否预留高度(默认true)
                primary: true,
                backgroundColor: Colors.blue,
                title: Text('Sliver AppBar'),
                //是否随着滑动隐藏标题
                floating: false,
                //与floating结合使用(控制展开区域是否跟随)
                snap: false,
                //是否固定在顶部
                pinned: false,
                // 展开的高度
                expandedHeight: 200.0,
                // 可以展开的区域
                flexibleSpace: FlexibleSpaceBar(
                  title: Text('我展开了'),
                  centerTitle: true,
                  collapseMode: CollapseMode.none,
                  background: Container(color: Colors.lightGreen),
                )),
            SliverFixedExtentList(
              itemExtent: 150.0,
              delegate: SliverChildListDelegate([
                Container(color: Colors.purple),
                Container(color: Colors.black26),
                Container(color: Colors.orange),
                Container(color: Colors.yellow),
                Container(color: Colors.pink),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
