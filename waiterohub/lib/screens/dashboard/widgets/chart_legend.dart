import 'package:flutter/material.dart';

class ChartLegend extends StatelessWidget {
  const ChartLegend({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFFEF7198),
            shape: BoxShape.circle,
          ),
          height: 12,
          width: 12,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "Today's orders",
          style: TextStyle(
            color: Colors.grey[600],
            letterSpacing: 0.7,
            fontFamily: 'Diodrum',
            fontSize: 14.0,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF5EC999),
            shape: BoxShape.circle,
          ),
          height: 12,
          width: 12,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          'Monthly Orders',
          style: TextStyle(
            color: Colors.grey[600],
            letterSpacing: 0.7,
            fontFamily: 'Diodrum',
            fontSize: 14.0,
          ),
        ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}