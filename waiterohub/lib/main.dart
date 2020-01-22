import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:waitero/providers/product.dart';
import 'package:waitero/providers/products.dart';
import 'package:waitero/routing/router.gr.dart';

void main() => runApp(WaiteroHubApp());

class WaiteroHubApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(<SystemUiOverlay>[]);

    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Product(),
        )
        // ChangeNotifierProvider<Product>.value(
        //   value: Product(),
        // ),
      ],
      child: MaterialApp(
        title: 'Waitero Hub',
        debugShowCheckedModeBanner: false,
        initialRoute: Router.orders,
        navigatorKey: Router.navigatorKey,
        onGenerateRoute: Router.onGenerateRoute,
      ),
    );
  }
}
