import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  Product({
    this.id,
    this.name,
    this.price,
    this.imageUrl,
  });

/*
  ! The factory gives us an easy way to create our personal objects from Firebase.
  ? Factory nam daje sposobnost lakog prebacivanja podataka iz Firebase-a u nas osobni model.
*/

  factory Product.fromDocument(DocumentSnapshot doc) {
    return Product(
      id: doc['productId'] as String,
      name: doc['name'] as String,
      price: doc['price'] as String,
      imageUrl: doc['imageUrl'] as String,
    );
  }

  /*
  ! 'toJson()' is a function which encodes our custom model to Json for Firebase.
  ? 'toJson()' je funkcija koja pretvara nas model u Json za Firebase
*/

  Map<String, String> toJson() {
    return <String, String>{
      'productId': id,
      'imageUrl': imageUrl,
      'name': name,
      'price': price,
    };
  }

  final String id;
  final String name;
  final String price;
  final String imageUrl;
  // final string description;

}
