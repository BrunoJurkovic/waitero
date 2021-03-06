import 'package:flutter/material.dart';
import 'package:waitero/components/nav_rail/nav_rail.dart';

// ! Custom scaffold has our setting pre-definied to save lines of code.
// ? Kako bi smo mogli 'reciklirati' scaffold i smanjiti broj linija, napravili smo model jer koristimo isti svugdje.

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key key,
    @required this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endFloat,
  }) : super(key: key);

  final Widget body;
  final FloatingActionButton floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;

  // ! In Flutter, the Scaffold widget provides a visual scaffold for all of the widget.
  // ? U Flutteru, Scaffold sluzi kao 'ljestve' za sve ostale widgete koje ce biti slozene na njega.

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        NavRail(),
        Expanded(
          child: Scaffold(
            backgroundColor: const Color(0xFFF8F7FC),
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomPadding: false,
            extendBody: true,
            floatingActionButton: floatingActionButton,
            body: body,
          ),
        ),
      ],
    );
  }
}
