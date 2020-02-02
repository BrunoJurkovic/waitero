import 'package:flutter/material.dart';
import 'package:waiteroclient/models/product.dart';
import 'package:waiteroclient/screens/order/mobile/widgets/product_item.dart';

class ProductsListMobile extends StatelessWidget {
  const ProductsListMobile({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: products.length,
      primary: false,
      itemBuilder: (_, int index) {
        return ProductItemMobile(
          product: products[index],
        );
      },
      separatorBuilder: (BuildContext _, int index) =>
          const SizedBox(height: 10),
    );
  }
}
