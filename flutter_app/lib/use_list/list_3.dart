import 'package:flutter/material.dart';

// ListView 3
// ListView.separated

class ListView3Page extends StatelessWidget {
  Widget _buildListView() {
    List list = [
      "java",
      "C++",
      "C#",
      "Python",
      "JavaScript",
      "Flutter",
      "SQL",
      "Dart",
      "apple",
      "height",
      "sun",
      "StatelessWidget",
      'Colors',
      'page',
      'CN'
          'dog',
      '#'
    ];
    return ListView.separated(
      padding: EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
//      shrinkWrap: true,
      itemCount: list.length,
      itemBuilder: (context, i) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: Text(
                '${list[i]}',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, i) {
        if (i == 4) {
          return Container(
            height: 30.0,
            child: new Center(
              child: new Text("类型1"),
            ),
            color: Colors.blue,
          );
        } else if (i == 8) {
          return Container(
            height: 30.0,
            child: new Center(
              child: new Text("类型2"),
            ),
            color: Colors.blue,
          );
        } else {
          return Container();
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
          title: Text('ListView.separated'),
        ),
        body: Container(
          child: _buildListView(),
        ),
      ),
    );
  }
}
