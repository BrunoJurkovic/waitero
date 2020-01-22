import 'package:flutter/material.dart';
import 'package:waitero/components/sidebar/sidebar.dart';
import 'package:waitero/routing/router.gr.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key key,
    @required this.body,
  }) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
              onPressed: () {
                Router.navigator.pushNamed(Router.orders);
              },
              splashColor: Colors.transparent,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue[900],
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Router.navigator.pushNamed(Router.manageProducts);
              },
              splashColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
