import 'package:flutter/material.dart';
import 'package:flutter_app/bottom_nav/tab/first.dart';
import 'package:flutter_app/bottom_nav/tab/second.dart';
import 'package:flutter_app/bottom_nav/tab/third.dart';

class Navigator2Page extends StatefulWidget {
  @override
  Navigator2State createState() => Navigator2State();
}

class Navigator2State extends State<Navigator2Page> {
  final _bottomNavigationColor = Colors.blue;
  int _currentIndex = 0;
  List<Widget> list = List();

  @override
  void initState() {
    list..add(FirstTab())..add(SecondTab())..add(ThirdTab());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: list[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        //shifting,fixed
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
