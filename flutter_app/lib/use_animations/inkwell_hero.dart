import 'package:flutter/material.dart';

//hero + 触摸水波纹动画

class InkWellPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('InkWell+Hero'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Center(
          child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DetailScreen()));
            },
            child: Hero(
              tag: 'test',
              child: Image.network(
                'https://tse3.mm.bing.net/th?id=OIP.CREXUbkxGDZ39n5DesDNkQHaE8&pid=Api',
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
              tag: 'test',
              child: Image.network(
                'https://tse3.mm.bing.net/th?id=OIP.CREXUbkxGDZ39n5DesDNkQHaE8&pid=Api',
              )),
        ),
      ),
    );
  }
}
