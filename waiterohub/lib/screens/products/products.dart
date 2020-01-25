import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/providers/product.dart';
import 'package:waitero/routing/router.gr.dart';
import 'package:waitero/screens/products/widgets/products_list.dart';
import 'package:waitero/services/database/products_repo.dart';

class ManageProductsPage extends StatelessWidget {
  const ManageProductsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductsRepository productsRepo =
        Provider.of<ProductsRepository>(context);

    return CustomScaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 34,
        ),
        onPressed: () {
          Router.navigator.pushNamed(Router.addProduct);
        },
        elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Manage Products',
                    style: GoogleFonts.alata(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32, top: 16),
                child: FutureBuilder<List<Product>>(
                  future: productsRepo.getAllProducts(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Product>> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return buildLoading(context);
                      case ConnectionState.done:
                        if (snapshot.hasData)
                          return ProductsList(products: snapshot.data);
                        if (snapshot.data.isEmpty)
                          return buildNoData(context);
                        break;
                      case ConnectionState.none:
                        return buildLoading(context);
                      case ConnectionState.active:
                        return buildLoading(context);
                    }
                    return buildLoading(context);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNoData(BuildContext context) {
    final double fontSize = MediaQuery.of(context).size.width / 20;

    return Center(
      child: Text(
        'No products, add some!',
        style: GoogleFonts.alata(fontSize: fontSize),
      ),
    );
  }

  Widget buildLoading(BuildContext context) {
    return Center(
      child: Container(
        child: const CircularProgressIndicator(),
        width: MediaQuery.of(context).size.width * 0.03,
        height: MediaQuery.of(context).size.height * 0.05,
      ),
    );
  }
}
