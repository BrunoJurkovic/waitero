import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waitero/components/loading/loading.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/providers/order.dart';
import 'package:waitero/screens/orders/widgets/indicator_dot.dart';
import 'package:waitero/screens/orders/widgets/order_item.dart';
import 'package:waitero/services/database/orders_repo.dart';

/*
  ! This screen shows all of the orders that are icoming.
  ? Na ovom screen-u moze se vidjeti sve narudzbe koje dolaze.
*/

class OrdersPage extends StatelessWidget {
  const OrdersPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final OrdersRepository orders = Provider.of<OrdersRepository>(context);

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
            Container(
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
            ),
            const SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
              stream: orders.ref.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const LoadingIndicator();
                } else {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: ListView.builder(
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
                              orderID: order.id,
                              status: status,
                              shouldBeGrey: index % 2 == 0,
                              tableID: order.tableID,
                              timestamp: order.timestamp,
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
