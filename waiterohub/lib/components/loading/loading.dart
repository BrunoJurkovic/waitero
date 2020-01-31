import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: const CircularProgressIndicator(),
        width: MediaQuery.of(context).size.width * 0.03,
        height: MediaQuery.of(context).size.height * 0.05,
      ),
    );
  }
}
