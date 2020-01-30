import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waitero/screens/orders/widgets/indicator_dot.dart';

class OrderItem extends StatelessWidget {
  const OrderItem(
      {Key key,
      this.status,
      this.tableID,
      this.orderID,
      this.timestamp,
      this.total})
      : super(key: key);

  final OrderStatus status;
  final String tableID;
  final String orderID;
  final DateTime timestamp;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.75,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              '#${orderID?.substring(0, 8)?.toUpperCase()}',
              style: TextStyle(
                fontFamily: 'Diodrum',
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Text(
                'TBL-$tableID',
                style: TextStyle(
                  fontFamily: 'Diodrum',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            IndicatorWidget(
              status: status,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1),
              child: Text(
                '\$$total',
                style: TextStyle(
                  fontFamily: 'Diodrum',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Text(
              '${DateFormat('HH:mm').format(timestamp.toLocal())}',
              style: TextStyle(
                fontFamily: 'Diodrum',
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
