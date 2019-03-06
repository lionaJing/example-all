import 'package:flutter/material.dart';

/// Navigate to a new screen and back

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Open route'),
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SecondRoute())
            );
          },
        ),
      ),
    );
  }
}

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second Route'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('back route'),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}