import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RestaurantTable with ChangeNotifier {
  RestaurantTable({
    this.id,
    this.qrCodeURL,
    this.position,
    this.isRound = false,
  });

  /*
  ! The factory gives us an easy way to create our personal objects from Firebase.
  ? Factory nam daje sposobnost lakog prebacivanja podataka iz Firebase-a u nas osobni model.
*/

  factory RestaurantTable.fromDocument(DocumentSnapshot doc) {
    final double positionX = doc['positionX'] as double;
    final double positionY = doc['positionY'] as double;
    final Offset offset = Offset(positionX, positionY);
    return RestaurantTable(
      id: doc['id'] as String,
      qrCodeURL: doc['imageUrl'] as String,
      position: offset,
      isRound: doc['isRound'] as bool,
    );
  }

  /*
  ! 'toJson()' is a function which encodes our custom model to Json for Firebase.
  ? 'toJson()' je funkcija koja pretvara nas model u Json za Firebase
*/

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'imageUrl': qrCodeURL,
      'positionX': position.dx,
      'positionY': position.dy,
      'isRound': isRound,
    };
  }

  set tablePosition(Offset newOffset) {
    position = newOffset;
    notifyListeners();
  }

  final String id;
  final String qrCodeURL;
  Offset position;
  final bool isRound;
}
