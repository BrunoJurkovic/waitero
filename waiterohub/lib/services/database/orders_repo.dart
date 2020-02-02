import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:waitero/providers/order.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:waitero/services/database/products_repo.dart';

/*
  ! This repo is used for managing all things related to orders.
  ? Ovaj repository se koristi za sve stvari vezane sa nadrudzbama.
*/

///! The enum [OrderSort] is used for simplifying the method of sort.
///
///? Ovaj enum [OrderSort] se korsti za pojednostavljanje nacina sortiranja narudzba.
enum OrderSort {
  Completed,
  Unfinished,
  Newest,
  Oldest,
}


///! The enum [OrderFetch] is used for simplifying the fetching of orders.
///
///? Ovaj enum [OrderFetch] se korsti za pojednostavljanje nacina na koji se potrazuju narudzbe.
enum OrderFetch {
  Monthly,
  Today,
}

class OrdersRepository with ChangeNotifier {
  ///!EN: As this class uses the [ProductsRepository] class, we need to import it.
  ///
  ///?HR: Ovaj class koristi [ProductsRepository], pa ga moramo importati.
  OrdersRepository(this._products);
  final ProductsRepository _products;
  
  ///!EN: We get a ref to the '/orders/' in the database.
  ///
  ///?HR: Spremimo ref od '/orders/' iz databaze.
  CollectionReference ref = Firestore.instance.collection('orders');


  ///!EN: This function returns a list of [Order], first it checks what the [sort] value is,
  ///! then it does a query with a limit of 100, to save on reads. Then from that query, we call 
  ///! [.map] on it which goes though all of the items, and returns a list of [Order].
  ///
  ///?HR: Ova funkcija vrati listu [Order], prvo provjeri koja je vrijednost [sort],
  ///? pa izvrsi query sa limitom 100, kako bi smo mogli sacuvati na readovima. Onda iz tog query-a
  ///? zovemo [.map] koji provrti kroz sve stvari, i onda vrati listu [Order].
  Future<List<Order>> getAllOrders(OrderSort sort) async {
    QuerySnapshot query;
    switch (sort) {
      case OrderSort.Completed:
        query = await ref
            .where('isCompleted', isEqualTo: true)
            .limit(100)
            .getDocuments();
        break;
      case OrderSort.Unfinished:
        query = await ref
            .where('isCompleted', isEqualTo: false)
            .limit(100)
            .getDocuments();
        break;
      case OrderSort.Newest:
        query = await ref
            .orderBy('timestamp', descending: true)
            .limit(100)
            .getDocuments();
        break;
      case OrderSort.Oldest:
        query = await ref
            .orderBy('timestamp', descending: false)
            .limit(100)
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
    for (dynamic id in productIDs) {
      final double price = await _products.getProductPrice(id as String);
      total += price;
    }
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
