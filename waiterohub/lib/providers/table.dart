import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantTable with ChangeNotifier {
  RestaurantTable({
    this.id,
    this.qrCodeURL,
    this.position,
  });

  factory RestaurantTable.fromDocument(DocumentSnapshot doc) {
    final double positionX = double.parse(doc['positionX'] as String);
    final double positionY = double.parse(doc['positionY'] as String);
    final Offset offset = Offset(positionX, positionY);
    return RestaurantTable(
      id: doc['productId'] as String,
      qrCodeURL: doc['imageUrl'] as String,
      position: offset,
    );
  }

  Map<String, String> toJson() {
    return <String, String>{
      'productId': id,
      'imageUrl': qrCodeURL,
      'positionX': position.dx.toString(),
      'positionY': position.dy.toString(),
    };
  }

  final String id;
  final String qrCodeURL;
  final Offset position;
}