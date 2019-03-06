import 'package:flutter/material.dart';

//ExpansionTiles可用于生成二级或多级列表

class ExpansionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: AppBar(
          title: new Text('多级列表'),
          leading: new IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => EntryItem(data[index], context),
          itemCount: data.length,
        ),
      ),
    );
  }
}

class Entry {
  final String title;
  final List<Entry> children;

  Entry(this.title, [this.children = const <Entry>[]]);
}

final List<Entry> data = <Entry>[
  Entry(
    'Chapter A',
    <Entry>[
      Entry(
        'Section A0',
        <Entry>[
          Entry('Item A0.1'),
          Entry('Item A0.2'),
          Entry('Item A0.3'),
        ],
      ),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
];

class EntryItem extends StatelessWidget {
  final Entry entry;
  final BuildContext context;

  const EntryItem(this.entry, this.context);

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Text(root.title),
        onTap: () {
          Scaffold.of(context).showSnackBar(new SnackBar(
            content: new Text(root.title),
            duration: new Duration(seconds: 2),
          ));
        },
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: new Text(root.title),
//      leading: Icon(Icons.color_lens),
      children: root.children.map<Widget>(_buildTiles).toList(),
      onExpansionChanged: (bool) {
        // 展开收缩监听
      },
      initiallyExpanded: false, //默认展开状态
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}
