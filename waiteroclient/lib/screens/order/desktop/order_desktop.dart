import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiteroclient/components/advertisement/bottom_advert.dart';
import 'package:waiteroclient/components/error/error.dart';
import 'package:waiteroclient/components/loading/loading_indicator.dart';
import 'package:waiteroclient/models/product.dart';
import 'package:waiteroclient/providers/cart.dart';
import 'package:waiteroclient/screens/order/desktop/widgets/mini_cart/mini_cart.dart';
import 'package:waiteroclient/screens/order/desktop/widgets/products_list.dart';
import 'package:waiteroclient/services/database/products_repository.dart';
import 'package:waiteroclient/theme/style.dart';

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
      return Center(
        child: Text(
          'No products, add some!',
          style: Style.common.copyWith(
            fontSize: MediaQuery.of(context).size.width / 20,
          ),
        ),
      );
    }

    Widget buildLoading() {
      final double loadingWidth = MediaQuery.of(context).size.width * 0.03;
      final double loadingHeight = MediaQuery.of(context).size.height * 0.05;
      return LoadingIndicator(
        width: loadingWidth,
        height: loadingHeight,
      );
    }

    return Consumer<CartProvider>(
      builder: (BuildContext context, CartProvider repo, _) {
        return Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Order',
                            style: Style.common.copyWith(fontSize: 30),
                          ),
                          Text(
                            'Table: ${Uri.base.queryParameters['tableID'] ?? 'No table'}',
                            style: Style.common.copyWith(fontSize: 30),
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
                                return buildLoading();
                              case ConnectionState.done:
                                if (snapshot.hasData) {
                                  return ProductsListDesktop(
                                    products: snapshot.data,
                                    provider: repo,
                                  );
                                }
                                if (snapshot.hasError) {
                                  return DisplayError(error: snapshot.error);
                                }
                                return buildNoData();
                              case ConnectionState.none:
                                return buildLoading();
                              case ConnectionState.active:
                                return buildLoading();
                              default: return const DisplayError(error: null);
                            }
                          },
                        ),
                      ),
                    ),
                    const BottomAdvertisement(),
                  ],
                ),
              ),
            ),
            MiniCart(provider: repo),
          ],
        );
      },
    );
  }
}
