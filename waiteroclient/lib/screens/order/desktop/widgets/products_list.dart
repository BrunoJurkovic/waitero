import 'package:flutter/material.dart';
import 'package:waiteroclient/models/product.dart';
import 'package:waiteroclient/screens/order/desktop/widgets/product_item.dart';

class ProductsListDesktop extends StatelessWidget {
  const ProductsListDesktop({
    Key key,
    @required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: GridView.builder(
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.3,
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
        ),
        primary: false,
        itemBuilder: (_, int index) {
          return ProductItemDesktop(
            product: products[index],
          );
        },
      ),
    );
  }
}
