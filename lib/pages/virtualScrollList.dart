import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: VirtualScrollList()));
}

class VirtualScrollList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VirtualScrollListState();
  }
}


class VirtualScrollListState extends State<VirtualScrollList> {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var height = mediaQuery.size.height;
    print(height);
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[

      ],
    );
  }
}
