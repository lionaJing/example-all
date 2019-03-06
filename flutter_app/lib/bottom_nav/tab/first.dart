import 'package:flutter/material.dart';

class FirstTab extends StatefulWidget {
  @override
  FirstState createState() => new FirstState();
}

class FirstState extends State<FirstTab> {
  String results = "";
  final TextEditingController controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(16.0),
      child: new Center(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new TextField(
              decoration: new InputDecoration(hintText: "Enter text here..."),
              onSubmitted: (String s) {
                setState(() {
                  results = results + ',' + s;
                  controller.text = '';
                });
              },
              controller: controller,
            ),
            new Text(results),
          ],
        ),
      ),
    );
  }
}
