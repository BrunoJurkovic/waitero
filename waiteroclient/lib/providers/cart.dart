import 'package:flutter/widgets.dart';
import 'package:waiteroclient/models/product.dart';

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = <Product>[];

  List<Product> get cartItems => _cartItems;

  void addCartItem(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeCartItem(Product product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}