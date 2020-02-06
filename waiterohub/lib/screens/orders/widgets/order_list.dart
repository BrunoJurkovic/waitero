import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waitero/providers/order.dart';
import 'package:waitero/screens/orders/widgets/indicator_dot.dart';
import 'package:waitero/screens/orders/widgets/order_item.dart';

class OrderList extends StatelessWidget {
  const OrderList({
    Key key, this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot<QuerySnapshot> snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data.documents.length,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (BuildContext ctx, int index) {
        final DocumentSnapshot doc =
            snapshot.data.documents[index];
        final Order order = Order.fromDocument(doc);
        final OrderStatus status = order.isCompleted
            ? OrderStatus.Completed
            : OrderStatus.Unfinished;
        return OrderItem(
          order: order,
          status: status,
          shouldBeGrey: index % 2 == 0,
        );
      },
    );
  }
}