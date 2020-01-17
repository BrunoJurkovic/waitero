import 'package:flutter/material.dart';

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
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFF43517A),
            Color(0xFF1D253E),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(child: body),
        drawer: drawer,
        extendBodyBehindAppBar: true,
      ),
    );
  }
}
