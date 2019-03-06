import 'package:flutter/material.dart';

///下拉框页面

class DropDownPage extends StatefulWidget {
  @override
  DropDownState createState() => new DropDownState();
}

class DropDownState extends State<DropDownPage> {
  List _fruits = ["Apple", "Banana", "Pineapple", "Mango", "Grapes"];
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _selectedFruit;

  @override
  void initState() {
    _dropDownMenuItems = buildAndGetDropDownMenuItems(_fruits);
    _selectedFruit = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List fruits) {
    List<DropdownMenuItem<String>> items = new List();
    for (String fruit in fruits) {
      items.add(new DropdownMenuItem(value: fruit, child: new Text(fruit)));
    }
    return items;
  }

  void changedDropDownItem(String selectedFruit) {
    setState(() {
      _selectedFruit = selectedFruit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("DropDown Button Example"),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Please choose a fruit: "),
                DropdownButton(
                    value: _selectedFruit,
                    items: _dropDownMenuItems,
                    onChanged: changedDropDownItem)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
