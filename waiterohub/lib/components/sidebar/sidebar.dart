import 'package:flutter/material.dart';

int _selectedIndex;

class Sidebar extends StatelessWidget {
  const Sidebar({
    Key key,
    this.body,
    this.items,
  }) : super(key: key);

  final Widget body;
  final List<Widget> items;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) => _selectedIndex = value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 75,
          color: Colors.blueAccent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: items,
          ),
        ),
        Expanded(child: body),
      ],
    );
  }
}
