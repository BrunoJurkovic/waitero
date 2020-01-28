import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waitero/providers/order.dart';

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

class OrdersRepository {
  CollectionReference ref = Firestore.instance.collection('orders');

  Future<List<Order>> getAllOrders(OrderSort sort) async {
    QuerySnapshot query;
    switch (sort) {
      case OrderSort.Completed:
        query = await ref.where('isCompleted', isEqualTo: true).getDocuments();
        break;
      case OrderSort.Unfinished:
        query = await ref.where('isCompleted', isEqualTo: false).getDocuments();
        break;
      case OrderSort.Newest:
        query = await ref.orderBy('timestamp', descending: true).getDocuments();
        break;
      case OrderSort.Oldest:
        query =
            await ref.orderBy('timestamp', descending: false).getDocuments();
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
          if (dateTime.month == order.timestamp.month) {
            validOrders.add(order);
          }
        });
        return validOrders.length;
      case OrderFetch.Today:
        final List<Order> orders = await getAllOrders(OrderSort.Newest);
        final List<Order> validOrders = <Order>[];
        orders.forEach((Order order) {
          final DateTime dateTime = DateTime.now();
          if (dateTime.day == order.timestamp.day) {
            validOrders.add(order);
          }
        });
        return validOrders.length;
    }
  }

  Future<void> completeOrder(String orderID) {
    return ref.document(orderID).updateData(
      <String, bool>{
        'isCompleted': true,
      },
    );
  }
}
