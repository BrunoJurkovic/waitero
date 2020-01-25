import 'package:flutter/material.dart';
import 'package:waitero/providers/product.dart';
import 'package:waitero/routing/router.gr.dart';
import 'package:waitero/screens/products/widgets/product_item.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
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
          return InkWell(
            onTap: () async {
              final Object response = await Router.navigator.pushNamed(
                Router.addProduct,
                arguments: AddProductPageArguments(
                  id: products[index].id,
                  imageUrl: products[index].imageUrl,
                  name: products[index].name,
                  price: products[index].price,
                ),
              );
              if (response != null) {
                products.removeWhere((Product item) => item.id == response);
              }
            },
            child: ProductItem(
              product: products[index],
            ),
          );
        },
      ),
    );
  }
}
