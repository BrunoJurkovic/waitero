import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  Product({
    this.id,
    this.name,
    this.price,
    this.imageId,
  });

  final String id;
  final String name;
  final double price;
  final String imageId;
  // final string description;

  final List<Product> _products = [
    Product(
      id: '0000',
      imageId:
          'https://spng.subpng.com/20171220/liw/coca-cola-bottle-png-image-5a3a9af89907b3.1328180915137902006268.jpg',
      name: 'Coca Cola',
      price: 5.00,
    ),
    Product(
      id: '0001',
      imageId:
          'https://img.favpng.com/20/12/7/soft-drink-sprite-bottle-png-favpng-Fku4usB9vnvJAE6ENk6Wyvcfm.jpg',
      name: 'Sprite',
      price: 2.00,
    ),
    Product(
      id: '0002',
      imageId:
          'https://banner2.cleanpng.com/20171217/8aa/cup-coffee-png-5a37379a797281.1466299915135681544975.jpg',
      name: 'Coffee',
      price: 3.00,
    ),
  ];

  List<Product> get products {
    return _products;
  }

  void addProduct(String id, String imageId, String name, double price) {
    _products.insert(
      0,
      Product(
        id: id,
        imageId: imageId,
        name: name,
        price: price,
      ),
    );
    notifyListeners();
  }
}
