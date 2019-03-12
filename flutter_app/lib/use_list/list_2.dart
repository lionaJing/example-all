import 'package:flutter/material.dart';

// ListView 2
//ListView.builder

class ListView2Page extends StatelessWidget {
  Widget _buildListView() {
    List list = [
      "java",
      "C++",
      "C#",
      "Python",
      "JavaScript",
      "Flutter",
      "SQL",
      "Dart"
    ];
    return ListView.builder(
      //如果增加分割线 就要 * 2
      itemCount: 8 * 2,
      //是否倒序显示(默认正序)
      reverse: false,
      //false，如果内容不足,无法滚动;true，它们总是可以尝试滚动
      primary: true,
      //确定每一个item的高度 会让item加载更加高效
      itemExtent: 36.0,
      //内容适配
      shrinkWrap: true,
      //滑动类型设置
      //AlwaysScrollableScrollPhysics() 总是可以滑动
      //NeverScrollableScrollPhysics禁止滚动
      //BouncingScrollPhysics 内容超过一屏 上拉有回弹效果
      //ClampingScrollPhysics 包裹内容 不会有回弹
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.all(4.0),
      //内间距
      cacheExtent: 30.0,
      //设置预加载的区域
      scrollDirection: Axis.vertical,
      itemBuilder: (context, i) {
        if (i.isOdd) {
          //是奇数 返回分割线
          return Divider(
            height: 1.0,
          );
        } else {
          i = i ~/ 2;
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                child: Text(
                  '${list[i]}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('ListView.builder'),
        ),
        body: Container(
          child: _buildListView(),
        ),
      ),
    );
  }
}
