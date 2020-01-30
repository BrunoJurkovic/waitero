import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waitero/screens/orders/widgets/indicator_dot.dart';
import 'package:waitero/services/database/orders_repo.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key key,
    this.status,
    this.tableID,
    this.orderID,
    this.timestamp,
  }) : super(key: key);

  final OrderStatus status;
  final String tableID;
  final String orderID;
  final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    final OrdersRepository orders = Provider.of<OrdersRepository>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
      child: FutureBuilder<double>(
          future: orders.calculateItemCost(orderID),
          builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            }
            print(snapshot.data);
            return ItemBody(
              orderID: orderID,
              tableID: tableID,
              status: status,
              timestamp: timestamp,
              total: snapshot.data,
            );
          }),
    );
  }
}

class ItemBody extends StatelessWidget {
  const ItemBody({
    Key key,
    @required this.orderID,
    @required this.tableID,
    @required this.status,
    @required this.timestamp,
    @required this.total,
  }) : super(key: key);

  final String orderID;
  final String tableID;
  final OrderStatus status;
  final DateTime timestamp;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            '#${orderID?.substring(0, 8)?.toUpperCase()}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Diodrum',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            'TBL-$tableID',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Diodrum',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          IndicatorWidget(
            status: status,
          ),
          Text(
            '\$$total',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Diodrum',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            '${DateFormat('HH:mm').format(timestamp.toLocal())}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Diodrum',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
