import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    Key key,
    this.body,
    this.appBar,
  }) : super(key: key);

  final Widget body;
  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      extendBodyBehindAppBar: appBar == null ? true : false,
      extendBody: true,
      backgroundColor: const Color(0xFFF8F7FC),
      appBar: appBar,
      body: body,
    );
  }
}
