import 'package:flutter/material.dart';
import 'package:flutter_app/go_state/use_state/decrement_state.dart';

//通过 setState() 管理状态
//这里用到了方法回调(回调的方法在父组件执行)

class StateHomePage extends StatefulWidget {
  @override
  StateHomeState createState() => StateHomeState();
}

class StateHomeState extends State<StateHomePage> {
  int counter;

  @override
  void initState() {
    super.initState();
    counter = counter ?? 0;
  }

  //减小
  void _decrementCounter(_) {
    setState(() {
      counter--;
    });
  }

  //增加
  void _incrementCounter(_) {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DecrementStatePage(
        counter: counter,
        decrementCounter: _decrementCounter,
        incrementCounter: _incrementCounter,
      ),
    );
  }
}
