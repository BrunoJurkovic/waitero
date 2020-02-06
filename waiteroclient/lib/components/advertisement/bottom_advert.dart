import 'package:flutter/material.dart';
import 'package:waiteroclient/theme/style.dart';

class BottomAdvertisement extends StatelessWidget {
  const BottomAdvertisement({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Text(
          'Powered by Waitero',
          style: Style.common.copyWith(fontSize: 10),
        ),
      ),
    );
  }
}