import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiteroclient/components/loading/loading_indicator.dart';
import 'package:waiteroclient/models/product.dart';
import 'package:waiteroclient/screens/order/desktop/widgets/products_list.dart';
import 'package:waiteroclient/services/database/products_repository.dart';

class OrderPageDesktop extends StatefulWidget {
  const OrderPageDesktop({Key key}) : super(key: key);

  @override
  _OrderPageDesktopState createState() => _OrderPageDesktopState();
}

class _OrderPageDesktopState extends State<OrderPageDesktop> {
  @override
  Widget build(BuildContext context) {
    final ProductsRepository productsRepo =
        Provider.of<ProductsRepository>(context);

    Widget buildNoData() {
      final double fontSize = MediaQuery.of(context).size.width / 20;

      return Center(
        child: Text(
          'No products, add some!',
          style: TextStyle(fontSize: fontSize, fontFamily: 'Diodrum'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 16),
          Text(
            'Order Desktop',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: 'Diodrum',
              fontSize: 30.0,
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
                      return const LoadingIndicator();
                    case ConnectionState.done:
                      if (snapshot.hasData)
                        return ProductsListDesktop(products: snapshot.data);
                      return buildNoData();
                    case ConnectionState.none:
                      return const LoadingIndicator();
                    case ConnectionState.active:
                      return const LoadingIndicator();
                    default:
                      return buildNoData();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
