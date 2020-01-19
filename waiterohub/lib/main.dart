import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waitero/screens/orders/orders.dart';

void main() => runApp(WaiteroHubApp());

class WaiteroHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);

    return MaterialApp(
      title: 'Waitero Hub',
      debugShowCheckedModeBanner: false,
      home: const OrdersPage(),
    );
  }
}
