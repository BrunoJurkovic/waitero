import 'package:flutter/material.dart';

class OrderPageDesktop extends StatefulWidget {
  const OrderPageDesktop({Key key}) : super(key: key);

  @override
  _OrderPageDesktopState createState() => _OrderPageDesktopState();
}

class _OrderPageDesktopState extends State<OrderPageDesktop> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 16),
          Text(
            'Order',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Diodrum',
              fontSize: 30.0,
            ),
          ),
        ],
      ),
    );
  }
}
