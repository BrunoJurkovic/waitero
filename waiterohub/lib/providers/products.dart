import 'package:flutter/material.dart';
import 'package:waitero/providers/product.dart';

class Products with ChangeNotifier {
  
  List<Product> _products = <Product>[
    Product(
      id: '0000',
      imageUrl:
          'https://spng.subpng.com/20171220/liw/coca-cola-bottle-png-image-5a3a9af89907b3.1328180915137902006268.jpg',
      name: 'Coca Cola',
      price: 5.00,
    ),
    Product(
      id: '0001',
      imageUrl:
          'https://img.favpng.com/20/12/7/soft-drink-sprite-bottle-png-favpng-Fku4usB9vnvJAE6ENk6Wyvcfm.jpg',
      name: 'Sprite',
      price: 2.00,
    ),
    Product(
      id: '0002',
      imageUrl:
          'https://banner2.cleanpng.com/20171217/8aa/cup-coffee-png-5a37379a797281.1466299915135681544975.jpg',
      name: 'Coffee',
      price: 3.00,
    ),
  ];

  List<Product> get products {
    return [..._products];
  }
}
