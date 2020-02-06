import 'package:flutter/material.dart';
import 'package:waiteroclient/theme/style.dart';

class DisplayError extends StatelessWidget {
  const DisplayError({Key key, this.error}) : super(key: key);

  final Object error;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            'Uh oh!',
            style: Style.common.copyWith(
              fontSize: MediaQuery.of(context).size.height / 20,
            ),
          ),
          Text(
            'An error occured',
            style: Style.common.copyWith(
              fontSize: MediaQuery.of(context).size.height / 30,
            ),
          ),
          Text(
            error.toString() ?? 'Not supposed to be here!',
            style: Style.common.copyWith(
              fontSize: MediaQuery.of(context).size.height / 30,
            ),
          ),
          Text(
            'Powered by Waitero',
            style: Style.common.copyWith(
              fontSize: MediaQuery.of(context).size.height / 50,
            ),
          ),
        ],
      ),
    );
  }
}
