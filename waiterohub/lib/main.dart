import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:waitero/providers/product.dart';
import 'package:waitero/providers/table.dart';
import 'package:waitero/routing/router.gr.dart';
import 'package:waitero/services/database/images_repo.dart';
import 'package:waitero/services/database/database_helper.dart';
import 'package:waitero/services/database/orders_repo.dart';
import 'package:waitero/services/database/products_repo.dart';
import 'package:waitero/services/database/tables_repo.dart';

void main() => runApp(WaiteroHubApp());

class WaiteroHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);

    return MultiProvider(
      providers: <SingleChildWidget>[
        // ChangeNotifierProvider<Products>(
        //   create: (_) => Products(),
        // ),
        ChangeNotifierProvider<Product>(create: (_) => Product()),
        ChangeNotifierProvider<RestaurantTable>(create: (_) => RestaurantTable()),
        Provider<DatabaseHelper>(create: (_) => DatabaseHelper()),
        Provider<ImagesRepository>(create: (_) => ImagesRepository()),
        Provider<ProductsRepository>(create: (_) => ProductsRepository()),
        Provider<TablesRepository>(create: (_) => TablesRepository(),),
        ChangeNotifierProxyProvider<ProductsRepository, OrdersRepository>(
          create: (_) => OrdersRepository(null),
          update: (_, ProductsRepository products, __) =>
              OrdersRepository(products),
        ),
      ],
      child: MaterialApp(
        title: 'Waitero Hub',
        debugShowCheckedModeBanner: false,
        initialRoute: Router.routes[0],
        navigatorKey: Router.navigatorKey,
        onGenerateRoute: Router.onGenerateRoute,
      ),
    );
  }
}
