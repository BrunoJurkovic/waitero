import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:waitero/providers/products.dart';
import 'package:waitero/routing/router.gr.dart';
import 'package:waitero/screens/orders/manage_product_screen.dart'; // ! temporary
import 'package:waitero/screens/orders/orders.dart';

void main() => runApp(WaiteroHubApp());

class WaiteroHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);

    return MultiProvider(
      providers: <SingleChildWidget>[
        Provider(
          create: (_) => Product(),
        ),
        // ChangeNotifierProvider<Product>.value(
        //   value: Product(),
        // ),
      ],
      child: MaterialApp(
        title: 'Waitero Hub',
        debugShowCheckedModeBanner: false,
        // home: const OrdersPage(),
        // ! temporary
        // home: const OrdersPage(),
        initialRoute: Router.orders,
        navigatorKey: Router.navigatorKey,
        onGenerateRoute: Router.onGenerateRoute,
      ),
    );
  }
}
