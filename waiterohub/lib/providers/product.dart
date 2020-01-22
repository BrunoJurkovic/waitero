import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  Product({
    this.id,
    this.name,
    this.price,
    this.imageUrl,
  });

  final String id;
  final String name;
  final double price;
  final String imageUrl;
  // final string description;

  
}
