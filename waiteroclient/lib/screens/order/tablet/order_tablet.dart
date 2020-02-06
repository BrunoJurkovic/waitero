import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiteroclient/components/advertisement/bottom_advert.dart';
import 'package:waiteroclient/components/loading/loading_indicator.dart';
import 'package:waiteroclient/components/no_data/no_data.dart';
import 'package:waiteroclient/models/product.dart';
import 'package:waiteroclient/providers/cart.dart';
import 'package:waiteroclient/router/router.gr.dart';
import 'package:waiteroclient/screens/order/tablet/widgets/products_list.dart';
import 'package:waiteroclient/services/database/products_repository.dart';
import 'package:waiteroclient/theme/style.dart';

class OrderPageTablet extends StatefulWidget {
  const OrderPageTablet({Key key}) : super(key: key);

  @override
  _OrderPageTabletState createState() => _OrderPageTabletState();
}

class _OrderPageTabletState extends State<OrderPageTablet> {
  @override
  Widget build(BuildContext context) {
    final ProductsRepository productsRepo =
        Provider.of<ProductsRepository>(context);

    return Consumer<CartProvider>(
      builder: (BuildContext context, CartProvider repo, Widget _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Order',
                    style: Style.common.copyWith(fontSize: 30),
                  ),
                  IconButton(
                    icon: Icon(Icons.shopping_cart),
                    onPressed: () {
                      Router.navigator.pushNamed(Router.cartPage);
                    },
                  ),
                ],
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
                            return ProductsListTablet(
                              products: snapshot.data,
                              provider: repo,
                            );
                          return const NoData();
                        case ConnectionState.none:
                          return const LoadingIndicator();
                        case ConnectionState.active:
                          return const LoadingIndicator();
                        default:
                          return const NoData();
                      }
                    },
                  ),
                ),
              ),
              const BottomAdvertisement()
            ],
          ),
        );
      },
    );
  }
}
