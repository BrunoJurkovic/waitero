import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/screens/orders/orders.dart';

void main() => runApp(WaiteroHubApp());

class WaiteroHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Waitero Hub',
      debugShowCheckedModeBanner: false,
      home: const OrdersPage(),
    );
  }
}
