import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waitero/components/loading/loading.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/screens/orders/widgets/order_legend.dart';
import 'package:waitero/screens/orders/widgets/order_list.dart';
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
            const OrderLegend(),
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
                        child: OrderList(snapshot: snapshot),
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
