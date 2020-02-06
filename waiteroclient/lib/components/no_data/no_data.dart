import 'package:flutter/material.dart';
import 'package:waiteroclient/theme/style.dart';

class NoData extends StatelessWidget {
  const NoData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No products, add some!',
        style: Style.common.copyWith(
          fontSize: MediaQuery.of(context).size.height / 20,
        ),
      ),
    );
  }
}
