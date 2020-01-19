import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/screens/orders/widgets/order_item.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Incoming Orders',
              style: GoogleFonts.pTSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 50.0,
              ),
            ),
            Expanded(
              child: ListView(
                primary: false,
                children: <Widget>[
                  OrderItem(),
                  OrderItem(),
                  OrderItem(),
                  OrderItem(),
                  OrderItem(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
