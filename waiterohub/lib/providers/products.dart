import 'package:flutter/material.dart';

class Products extends ChangeNotifier {
  Products(
    this.id,
    this.name,
    this.price,
  );

  final String id;
  final String name;
  final String price;
  // final string description;
}
