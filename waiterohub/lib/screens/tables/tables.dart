import 'package:flutter/material.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Tables',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Diodrum',
                  fontSize: 30.0,
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
