import 'package:flutter/material.dart';

///路由-主页

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          title: new Text("新闻主页"),
          leading: new IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: new Container(
          padding: const EdgeInsets.all(16),
          child: new Column(
            children: <Widget>[
              new Image.network('http://d.ifengimg.com/w650_h390_q70/'
                  'p3.ifengimg.com/'
                  '2019_08/6B3F7E2B8FB034162423A2E0A4779B023952A291_w650_h390.png'),
              new Container(
                margin: EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: new Text(
                  'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
                      'Alps. Situated 1,578 meters above sea level, it is one of the '
                      'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
                      'half-hour walk through pastures and pine forest, leads you to the '
                      'lake, which warms to 20 degrees Celsius in the summer. Activities '
                      'enjoyed here include rowing, and riding the summer toboggan run.',
                  softWrap: true,
                ),
              ),
              new Image.network('https://wx3.sinaimg.cn/large/'
                  '44f5e7f7ly1g0ef27k3cxj21930u0doj.jpg'),
              new RaisedButton(
                  child: new Text('进入about'),
                  textColor: Colors.black,
                  color: Colors.white,
                  highlightColor: Colors.black26,
                  padding: new EdgeInsets.all(8),
                  onPressed: () {
                    Navigator.pushNamed(context, '/about');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
