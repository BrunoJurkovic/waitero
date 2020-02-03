import 'package:flutter/material.dart';
import 'package:waitero/components/fade_in/fade_in.dart';
import 'package:waitero/providers/product.dart';
import 'package:waitero/routing/router.gr.dart';
import 'package:waitero/screens/products/widgets/product_item.dart';

/*
  ! This widget is used for displaying all of the products.
  ? Ovaj widget se koristi za prikazivanje svih proizovda.
*/

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

/*
  ! We use a GridView.builder which is a fast method of displaying the products and updating them fast.
  ? Korisitmo GridView.builder koji je optimiziran za ovakav nacin prikazivanja i azuriranja proizovda.
*/
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
          return FadeIn(
            delay: 0.45 * index,
            child: InkWell(
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
            ),
          );
        },
      ),
    );
  }
}
