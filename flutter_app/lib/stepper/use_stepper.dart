import 'package:flutter/material.dart';

//使用 stepper 进度步骤组件(布进器)

class StepperPage extends StatefulWidget {
  @override
  StepperState createState() => new StepperState();
}

class StepperState extends State<StepperPage> {
  int current_step = 0;
  List<Step> my_steps = [
    new Step(
      title: new Text('Step 1'),
      content: new Text("Hello"),
      isActive: true,
    ),
    new Step(
      title: new Text('Step 2'),
      content: new Text("World!"),
      isActive: true,
    ),
    new Step(
      title: new Text('Step 3'),
      content: new Text("Hello World!"),
      isActive: true,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          title: new Text('Stepper example'),
          leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Stepper(
            steps: my_steps,
            currentStep: this.current_step,
            // 进度的格式
            // StepperType.horizontal :  水平
            // StepperType.vertical   :  垂直
            type: StepperType.vertical,
            // 点击步骤时的回调
            onStepTapped: (step) {
              setState(() {
                current_step = step;
              });
            },
            //点击取消按钮
            onStepCancel: () {
              setState(() {
                if (current_step > 0) {
                  current_step = current_step - 1;
                } else {
                  current_step = 0;
                }
              });
            },
            // 在按下继续按钮时，更改状态。
            onStepContinue: () {
              setState(() {
                if (current_step < my_steps.length - 1) {
                  current_step = current_step + 1;
                } else {
                  current_step = 0;
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
