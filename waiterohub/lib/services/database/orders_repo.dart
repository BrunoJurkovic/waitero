import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:waitero/providers/order.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:waitero/services/database/products_repo.dart';

enum OrderSort {
  Completed,
  Unfinished,
  Newest,
  Oldest,
}

enum OrderFetch {
  Monthly,
  Today,
}

class OrdersRepository with ChangeNotifier {
  OrdersRepository(this._products);
  final ProductsRepository _products;
  CollectionReference ref = Firestore.instance.collection('orders');

  Future<List<Order>> getAllOrders(OrderSort sort) async {
    QuerySnapshot query;
    switch (sort) {
      case OrderSort.Completed:
        query = await ref
            .where('isCompleted', isEqualTo: true)
            .limit(250)
            .getDocuments();
        break;
      case OrderSort.Unfinished:
        query = await ref
            .where('isCompleted', isEqualTo: false)
            .limit(250)
            .getDocuments();
        break;
      case OrderSort.Newest:
        query = await ref
            .orderBy('timestamp', descending: true)
            .limit(250)
            .getDocuments();
        break;
      case OrderSort.Oldest:
        query = await ref
            .orderBy('timestamp', descending: false)
            .limit(250)
            .getDocuments();
        break;
    }
    final List<Order> allOrders = query.documents
        .map((DocumentSnapshot doc) => Order.fromDocument(doc))
        .toList();
    return allOrders;
  }

  Future<int> countOrders(OrderFetch orderFetch) async {
    switch (orderFetch) {
      case OrderFetch.Monthly:
        final List<Order> orders = await getAllOrders(OrderSort.Newest);
        final List<Order> validOrders = <Order>[];
        orders.forEach((Order order) {
          final DateTime dateTime = DateTime.now();
          if (dateTime.month == order.timestamp.month &&
              dateTime.year == order.timestamp.year) {
            validOrders.add(order);
          }
        });
        return validOrders.length;
      case OrderFetch.Today:
        final List<Order> orders = await getAllOrders(OrderSort.Newest);
        final List<Order> validOrders = <Order>[];
        orders.forEach((Order order) {
          final DateTime dateTime = DateTime.now();
          final DateTime ordertime = order.timestamp;
          if (dateTime.day == ordertime.day &&
              dateTime.year == ordertime.year) {
            validOrders.add(order);
          }
        });
        return validOrders.length;
    }
  }

  Future<double> calculateItemCost(String id) async {
    final QuerySnapshot query =
        await ref.where('id', isEqualTo: id).getDocuments();
    final List<Order> allOrders = query.documents
        .map((DocumentSnapshot doc) => Order.fromDocument(doc))
        .toList();

    final List<dynamic> productIDs = allOrders[0].products;
    double total = 0;
    productIDs.forEach((dynamic id) async {
      final double price = await _products.getProductPrice(id as String);
      total = total + price;
    });
    return total;
  }

  //todo make this work

  // Future<List<FlSpot>> getChartPositions(OrderFetch orderFetch) async {
  //   final List<Order> orders = await getAllOrders(OrderSort.Newest);
  //   final List<Order> validOrders = <Order>[];
  //   orders.forEach((Order order) {

  //     final DateTime dateTime = DateTime.now();
  //     if (dateTime.month == order.timestamp.month &&
  //         dateTime.year == order.timestamp.year) {
  //       validOrders.add(order);
  //     }
  //   });

  //   final List<FlSpot> spots = <FlSpot>[];
  //   double count = 0;

  // }

  // Future<void> completeOrder(String orderID) {
  //   return ref.document(orderID).updateData(
  //     <String, bool>{
  //       'isCompleted': true,
  //     },
  //   );
  // }
}
