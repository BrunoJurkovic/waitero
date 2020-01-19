import 'package:flutter/material.dart';
import 'package:waitero/components/sidebar/sidebar.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key key,
    @required this.body,
    this.drawer,
  }) : super(key: key);

  final Widget body;
  final Widget drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      drawer: drawer,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomPadding: false,
      extendBody: true,
      body: Sidebar(
        body: body,
        items: <Widget>[
//          TODO: add isSelected or something
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: IconButton(
              icon: Icon(Icons.grid_on),
              onPressed: () {},
              splashColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
