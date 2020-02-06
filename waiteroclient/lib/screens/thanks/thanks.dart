import 'package:flutter/material.dart';
import 'package:waiteroclient/components/scaffold/custom_scaffold.dart';
import 'package:waiteroclient/theme/style.dart';

class ThanksPage extends StatelessWidget {
  const ThanksPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Thanks for ordering!',
                  style: Style.common.copyWith(
                    fontSize: MediaQuery.of(context).size.height / 20,
                  ),
                ),
                Text(
                  'It will be completed shortly.',
                  style: Style.common.copyWith(
                    fontSize: MediaQuery.of(context).size.height / 30,
                  ),
                ),
              ],
            ),
            Text(
              'Powered by Waitero.',
              style: Style.common.copyWith(
                fontSize: MediaQuery.of(context).size.height / 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
