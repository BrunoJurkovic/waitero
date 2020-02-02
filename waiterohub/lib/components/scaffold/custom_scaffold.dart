import 'package:flutter/material.dart';
import 'package:waitero/components/nav_rail/nav_rail.dart';

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
