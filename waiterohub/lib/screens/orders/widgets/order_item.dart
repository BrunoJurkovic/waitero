import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waitero/screens/orders/widgets/indicator_dot.dart';
import 'package:waitero/services/database/orders_repo.dart';

/*
  ! OrderItem is a individual line for an order, has all of the necesary things for management to see where to deliver.
  ? OrderItem je jedan individualni red za narudzbu, sadrzi sve potrebne stavke kako bi management mogao znati gdje dostaviti narudzbu.
*/

class OrderItem extends StatelessWidget {
  const OrderItem({
    this.status,
    this.tableID,
    this.orderID,
    this.timestamp,
    this.shouldBeGrey,
  });

  final OrderStatus status;
  final String tableID;
  final String orderID;
  final DateTime timestamp;
  final bool shouldBeGrey;

  @override
  Widget build(BuildContext context) {
    final OrdersRepository orders = Provider.of<OrdersRepository>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: FutureBuilder<double>(
        future: orders.calculateItemCost(orderID),
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          }
          return ItemBody(
            orderID: orderID,
            tableID: tableID,
            status: status,
            timestamp: timestamp,
            total: snapshot.data,
            shouldBeGrey: shouldBeGrey,
          );
        },
      ),
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
    @required this.shouldBeGrey,
  }) : super(key: key);

  final String orderID;
  final String tableID;
  final OrderStatus status;
  final DateTime timestamp;
  final double total;
  final bool shouldBeGrey;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.75,
      child: Container(
        color: shouldBeGrey ? const Color(0xFFF8F7FC) : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 150,
              child: Text(
                '#${orderID?.substring(0, 8)?.toUpperCase()}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Diodrum',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                'TBL-$tableID',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Diodrum',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            IndicatorWidget(
              status: status,
            ),
            Container(
              width: 100,
              child: Text(
                '$total \$',
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'Diodrum',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              width: 100,
              child: Text(
                '${DateFormat('HH:mm').format(timestamp.toLocal())}',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Diodrum',
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
