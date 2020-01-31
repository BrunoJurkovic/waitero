import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantTable with ChangeNotifier {
  RestaurantTable({
    this.id,
    this.qrCodeURL,
    this.position,
  });

  factory RestaurantTable.fromDocument(DocumentSnapshot doc) {
    final double positionX = doc['positionX'] as double;
    final double positionY = doc['positionY'] as double;
    final Offset offset = Offset(positionX, positionY);
    return RestaurantTable(
      id: doc['id'] as String,
      qrCodeURL: doc['imageUrl'] as String,
      position: offset,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': qrCodeURL,
      'positionX': position.dx,
      'positionY': position.dy,
    };
  }

  final String id;
  final String qrCodeURL;
  final Offset position;
}