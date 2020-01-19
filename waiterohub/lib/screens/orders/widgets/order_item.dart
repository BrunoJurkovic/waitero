import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width * 0.8;
    final BorderRadius radius = BorderRadius.circular(10);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: radius),
      elevation: 0,
      color: const Color(0xFF474F98),
      child: Container(
        width: width,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Order ID: orderId',
                style: GoogleFonts.oxygen(color: Colors.white, fontSize: 30),
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_right),
              iconSize: 48,
              color: Colors.grey,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
