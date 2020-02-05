import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_utils/date_utils.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:waitero/providers/order.dart';
import 'package:waitero/services/database/products_repo.dart';
import 'package:waitero/util/date_util.dart';

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

  AudioPlayer audioPlayer = AudioPlayer();

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
    print('aa1');
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
    print('aa2');
    final List<Order> orders = await getAllOrders(OrderSort.Newest);
    final List<Order> validOrders = <Order>[];
    switch (orderFetch) {
      case OrderFetch.Monthly:
        validOrders.addAll(orders.where(
          (Order order) => order.timestamp.isAfter(
            DateUtils.getMonthDate(),
          ),
        ));
        break;
      case OrderFetch.Today:
        validOrders.addAll(orders.where(
          (Order order) => order.timestamp.isAfter(
            DateUtils.getTodaysDate(),
          ),
        ));
        break;
    }
    return validOrders.length;
  }

  Future<double> calculateItemCost(String id) async {
    print('aa3');
    final QuerySnapshot query =
        await ref.where('id', isEqualTo: id).getDocuments();
    final List<Order> allOrders = query.documents
        .map((DocumentSnapshot doc) => Order.fromDocument(doc))
        .toList();

    final List<dynamic> productIDs = allOrders[0].productIDs;
    double total = 0;
    for (final dynamic id in productIDs) {
      final double price = await _products.getProductPrice(id as String);
      total += price;
    }
    return total;
  }

  //todo make this work

  Future<List<FlSpot>> calculateGraphDots(OrderFetch time) async {
    print('aa4');
    final List<FlSpot> spots = <FlSpot>[];
    switch (time) {
      case OrderFetch.Monthly:
        final List<Order> ordersInMonth = <Order>[];
        final DateTime month = DateUtils.getMonthDate();
        final DateTime lastDay = Utils.lastDayOfMonth(month);
        final QuerySnapshot query = await ref
            .where('timestamp',
                isGreaterThanOrEqualTo: month.millisecondsSinceEpoch)
            .orderBy('timestamp', descending: true)
            .getDocuments();
        for (int i = 1; i <= lastDay.day; i++) {
          ordersInMonth.addAll(query.documents
              .map((DocumentSnapshot doc) => Order.fromDocument(doc))
              .where((Order order) {
            return order.timestamp.isAfter(month.add(Duration(days: i)));
          }).where((Order order) {
            return order.timestamp.isBefore(month.add(Duration(days: i + 1)));
          }).toList());
        }
        for (int i = 1; i <= lastDay.day; i++) {
          final List<Order> todaysOrders = ordersInMonth
              .where((Order order) => order.timestamp.day == i)
              .toList();
          spots.add(FlSpot(i.toDouble(), todaysOrders.length.toDouble()));
        }
        break;
      case OrderFetch.Today:
      print('aa5');
        final List<List<Order>> ordersInDay = <List<Order>>[];
        final DateTime day = DateUtils.getTodaysDate();
        final QuerySnapshot query = await ref
            .where('timestamp',
                isGreaterThanOrEqualTo: day.millisecondsSinceEpoch)
            .orderBy('timestamp', descending: true)
            .getDocuments();
        for (int i = 0; i <= 24; i++) {
          ordersInDay.add(query.documents
              .map((DocumentSnapshot doc) => Order.fromDocument(doc))
              .where((Order order) {
            return order.timestamp.isAfter(day.add(Duration(hours: i)));
          }).where((Order order) {
            return order.timestamp.isBefore(day.add(Duration(hours: i + 1)));
          }).toList());
        }
        for (final List<Order> orders in ordersInDay) {
          if (orders.isEmpty) {
            spots.add(FlSpot(ordersInDay.indexOf(orders).toDouble(), 0));
            continue;
          }
          spots.add(
            FlSpot(
              orders.first.timestamp.hour.toDouble(),
              orders.length.toDouble(),
            ),
          );
        }
        break;
    }
    return spots;
  }
}
