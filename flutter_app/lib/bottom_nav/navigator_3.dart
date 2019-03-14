import 'package:flutter/material.dart';
import 'package:flutter_app/bottom_nav/tab/first.dart';
import 'package:flutter_app/bottom_nav/tab/second.dart';
import 'package:flutter_app/bottom_nav/tab/third.dart';

//keep alive,保持状态

class Navigator3Page extends StatefulWidget {
  @override
  _Navigator3State createState() => _Navigator3State();
}

class _Navigator3State extends State<Navigator3Page>
    with SingleTickerProviderStateMixin {
  final _bottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = List();
  var _controller = PageController(
    //初始化当前显示的页面
    initialPage: 0,
    //每个页面应占用的视口部分(默认1 全屏展示)
    viewportFraction: 1,
  );

  @override
  void initState() {
    list..add(FirstTab())..add(SecondTab())..add(ThirdTab());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  //点击导航到下一页面
  void _goPage(index) {
    _controller.jumpToPage(index);
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: list,
        //NeverScrollableScrollPhysics 不可以滑动
        //BouncingScrollPhysics ios滑动效果
        //ClampingScrollPhysics android滑动效果
        //PageScrollPhysics 适用于PageView的滑动
        physics: PageScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _goPage,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _bottomNavigationColor,
            ),
            title: Text(
              'Email',
              style: TextStyle(color: _bottomNavigationColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.pages,
              color: _bottomNavigationColor,
            ),
            title: Text(
              'PAGES',
              style: TextStyle(color: _bottomNavigationColor),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.airplay,
              color: _bottomNavigationColor,
            ),
            title: Text(
              'AIRPLAY',
              style: TextStyle(color: _bottomNavigationColor),
            ),
          ),
        ],
      ),
    );
  }
}
