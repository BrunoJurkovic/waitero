import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiteroclient/components/advertisement/bottom_advert.dart';
import 'package:waiteroclient/components/error/error.dart';
import 'package:waiteroclient/components/loading/loading_indicator.dart';
import 'package:waiteroclient/components/no_data/no_data.dart';
import 'package:waiteroclient/models/product.dart';
import 'package:waiteroclient/providers/cart.dart';
import 'package:waiteroclient/router/router.gr.dart';
import 'package:waiteroclient/screens/order/mobile/widgets/products_list.dart';
import 'package:waiteroclient/services/database/products_repository.dart';
import 'package:waiteroclient/theme/style.dart';

class OrderPageMobile extends StatefulWidget {
  const OrderPageMobile({Key key}) : super(key: key);

  @override
  _OrderPageMobileState createState() => _OrderPageMobileState();
}

class _OrderPageMobileState extends State<OrderPageMobile> {
  @override
  Widget build(BuildContext context) {
    final ProductsRepository productsRepo =
        Provider.of<ProductsRepository>(context);

    Widget buildLoading() {
      final double loadingWidth = MediaQuery.of(context).size.width * 0.03;
      final double loadingHeight = MediaQuery.of(context).size.height * 0.05;
      return LoadingIndicator(
        width: loadingWidth,
        height: loadingHeight,
      );
    }

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
                          if (snapshot.hasData) {
                            return ProductsListMobile(
                              products: snapshot.data,
                              provider: repo,
                            );
                          }
                          if (snapshot.hasError) {
                            DisplayError(error: snapshot.error);
                          }
                          return const NoData();
                        case ConnectionState.none:
                          return const LoadingIndicator();
                        case ConnectionState.active:
                          return const LoadingIndicator();
                        default:
                          return const DisplayError(error: null);
                      }
                    },
                  ),
                ),
              ),
              const BottomAdvertisement(),
            ],
          ),
        );
      },
    );
  }
}
