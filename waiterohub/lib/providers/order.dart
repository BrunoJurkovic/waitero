import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/*
  ! We use a state management system called provider which handles our state.
  ? Koristimo state management sustav koji se zove Provider, koji nam cuva state.
*/


class Order with ChangeNotifier {
  Order({
    this.id,
    this.tableID,
    this.isCompleted = false,
    this.productIDs,
    this.timestamp,
  });

  /*
  ! Generally, all of our classes/models have the same 'base' which we adapt to different types.
  ? Generalno, u svim nasim classama/modelima koristimo istu bazu/template koju adaptiramo po potrebi.
*/

/*
  ! The factory gives us an easy way to create our personal objects from Firebase.
  ? Factory nam daje sposobnost lakog prebacivanja podataka iz Firebase-a u nas osobni model.
*/

  factory Order.fromDocument(DocumentSnapshot doc) {
    return Order(
      id: doc['id'] as String,
      tableID: doc['tableID'] as String,  
      isCompleted: doc['isCompleted'] as bool,
      productIDs: doc['products'] as List<dynamic>,
      timestamp: DateTime.fromMillisecondsSinceEpoch(doc['timestamp'] as int),
    );
  }

  /*
  ! 'toJson()' is a function which encodes our custom model to Json for Firebase.
  ? 'toJson()' je funkcija koja pretvara nas model u Json za Firebase
*/

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'tableID': tableID,
      'isCompleted': isCompleted,
      'products': productIDs,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  final String id;
  final String tableID;
  final bool isCompleted;
  final List<dynamic> productIDs;
  final DateTime timestamp;
}
