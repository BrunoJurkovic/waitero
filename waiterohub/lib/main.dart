import 'package:flutter/material.dart';
import 'package:waitero/routing/router.gr.dart';
import 'package:waitero/screens/orders/orders.dart';

void main() => runApp(WaiteroHubApp());

class WaiteroHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waitero Hub',
      debugShowCheckedModeBanner: false,
      home: const OrdersPage(),
      initialRoute: Router.orders,
      navigatorKey: Router.navigatorKey,
      onGenerateRoute: Router.onGenerateRoute,
    );
  }
}
