import 'package:flutter/material.dart';

class OrderLegend extends StatelessWidget {
  const OrderLegend({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: 150,
            child: Text(
              'Order ID',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Diodrum',
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            width: 100,
            child: Text(
              'Table ID',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Diodrum',
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            width: 140,
            child: Text(
              'Order Status',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Diodrum',
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            width: 75,
            child: Text(
              'Total',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'Diodrum',
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Container(
            width: 100,
            child: Text(
              'Time',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Diodrum',
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}