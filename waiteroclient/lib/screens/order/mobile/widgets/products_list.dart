import 'package:flutter/material.dart';
import 'package:waiteroclient/models/product.dart';
import 'package:waiteroclient/providers/cart.dart';
import 'package:waiteroclient/screens/order/mobile/widgets/product_item.dart';

class ProductsListMobile extends StatelessWidget {
  const ProductsListMobile({
    Key key,
    @required this.products,
    @required this.provider,
  }) : super(key: key);

  final List<Product> products;
  final CartProvider provider;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      primary: false,
      itemBuilder: (_, int index) {
        return ProductItemMobile(
          product: products[index],
          onPressed: (Product product) {
            provider.addCartItem(product);
          },
        );
      },
      separatorBuilder: (_, int index) =>
          const SizedBox(height: 10),
    );
  }
}
