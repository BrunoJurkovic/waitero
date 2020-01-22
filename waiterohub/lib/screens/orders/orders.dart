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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Incoming Orders',
                style: GoogleFonts.alata(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32.0, top: 16),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: ListView(
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: <Widget>[
                      OrderItem(),
                      OrderItem(),
                      OrderItem(),
                      OrderItem(),
                      OrderItem(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}