import 'package:flutter/material.dart';
import 'package:waiteroclient/models/product.dart';
import 'package:waiteroclient/providers/cart.dart';
import 'package:waiteroclient/screens/order/tablet/widgets/product_item.dart';

class ProductsListTablet extends StatelessWidget {
  const ProductsListTablet({
    Key key,
    @required this.products,
    @required this.provider,
  }) : super(key: key);

  final List<Product> products;
  final CartProvider provider;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1.3,
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
      ),
      primary: false,
      itemBuilder: (_, int index) {
        return ProductItemTablet(
          product: products[index],
          onPressed: (Product product) {
            provider.addCartItem(product);
          },
        );
      },
    );
  }
}
