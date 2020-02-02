import 'package:flutter/material.dart';

class UnsupportedPlatform extends StatelessWidget {
  const UnsupportedPlatform({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('This device is unsupported.'),
    );
  }
}
