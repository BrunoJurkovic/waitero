import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/providers/order.dart';
import 'package:waitero/screens/orders/widgets/indicator_dot.dart';
import 'package:waitero/screens/orders/widgets/order_item.dart';
import 'package:waitero/services/database/orders_repo.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrdersRepository orders = Provider.of<OrdersRepository>(context);

    Widget buildLoading(BuildContext context) {
      return Center(
        child: Container(
          child: const CircularProgressIndicator(),
          width: MediaQuery.of(context).size.width * 0.03,
          height: MediaQuery.of(context).size.height * 0.05,
        ),
      );
    }

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
                style: TextStyle(
                  color: const Color(0xFF20212C),
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Diodrum',
                  fontSize: 30.0,
                ),
              ),
            ),
            const SizedBox(height: 8),
            StreamBuilder<QuerySnapshot>(
                stream: orders.ref.snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return buildLoading(context);
                  } else {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 32.0, top: 16),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (BuildContext ctx, int index) {
                              final DocumentSnapshot doc = snapshot.data.documents[index];
                              final Order order = Order.fromDocument(doc);
                              final OrderStatus status = order.isCompleted ? OrderStatus.Completed : OrderStatus.Unfinished;
                              return OrderItem(orderID: order.id, status: status, tableID: order.tableID, timestamp: order.timestamp, total: '1400',);
                            },
                          ),
                        ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
