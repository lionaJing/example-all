import 'package:flutter/material.dart';
//seekBar

class SliderPage extends StatefulWidget {
  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<SliderPage> {
  double _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('seekBar'),
      ),
      body: Center(
        child: Slider(
          value: _value,
          max: 100,
          min: 0,
          onChanged: (mValue) {
            setState(() {
              _value = mValue;
            });
          },
          divisions: 100,
          //进度分割为多少份
          label: '${_value.floor()}',
          onChangeEnd: (mValue) {
            setState(() {
              _value = mValue;
            });
          },
          onChangeStart: (mValue) {},
        ),
      ),
    );
  }
}
