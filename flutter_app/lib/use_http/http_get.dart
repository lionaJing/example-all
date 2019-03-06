import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// http get
class MyHttpGetPage extends StatefulWidget {
  @override
  MyHttpGetState createState() => new MyHttpGetState();
}

class MyHttpGetState extends State<MyHttpGetPage> {
  final String url = "https://swapi.co/api/people";
  List data;

  //异步 HTTP 获取数据
  Future<String> getJSONData() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

    setState(() {
      var dataConvertedToJSON = jsonDecode(response.body);
      data = dataConvertedToJSON['results'];
    });
    return "Successfull";
  }

  @override
  void initState() {
    super.initState();
    this.getJSONData();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          title: new Text('Http Get Example'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (context, index) {
              return new Container(
                child: new Center(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Card(
                        child: new Container(
                          child: new Text(
                            data[index]['name'],
                            style: new TextStyle(
                                fontSize: 20.0, color: Colors.lightBlueAccent),
                          ),
                          padding: EdgeInsets.all(8.0),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
