import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:waitero/providers/product.dart';

class Order with ChangeNotifier {
  Order({
    this.id,
    this.tableID,
    this.isCompleted = false,
    this.products,
    this.timestamp,
  });

  factory Order.fromDocument(DocumentSnapshot doc) {
    return Order(
      id: doc['id'] as String,
      tableID: doc['tableID'] as String,
      isCompleted: doc['isCompleted'] as bool,
      products: doc['products'] as List<dynamic>,
      timestamp: DateTime.fromMillisecondsSinceEpoch(doc['timestamp'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'tableID': tableID,
      'isCompleted': isCompleted,
      'products': products,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  final String id;
  final String tableID;
  final bool isCompleted;
  final List<dynamic> products;
  final DateTime timestamp;
}
