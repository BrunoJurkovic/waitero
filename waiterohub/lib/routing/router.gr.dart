// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:waitero/screens/dashboard/dashboard.dart';
import 'package:auto_route/transitions_builders.dart';
import 'package:waitero/screens/orders/orders.dart';
import 'package:waitero/screens/products/products.dart';
import 'package:waitero/screens/tables/tables.dart';
import 'package:waitero/screens/products/add_product/add_product.dart';

class Router {
  static const dashboard = '/';
  static const orders = '/orders';
  static const manageProducts = '/manage-products';
  static const tables = '/tables';
  static const addProduct = '/add-product';
  static const routes = [
    dashboard,
    orders,
    manageProducts,
    tables,
    addProduct,
  ];
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.dashboard:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return PageRouteBuilder(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              DashboardPage(key: typedArgs),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.zoomIn,
        );
      case Router.orders:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return PageRouteBuilder(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              OrdersPage(key: typedArgs),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.zoomIn,
        );
      case Router.manageProducts:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return PageRouteBuilder(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              ManageProductsPage(key: typedArgs),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.zoomIn,
        );
      case Router.tables:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return PageRouteBuilder(
          pageBuilder: (ctx, animation, secondaryAnimation) =>
              TablesPage(key: typedArgs),
          settings: settings,
          transitionsBuilder: TransitionsBuilders.zoomIn,
          fullscreenDialog: true,
        );
      case Router.addProduct:
        if (hasInvalidArgs<AddProductPageArguments>(args)) {
          return misTypedArgsRoute<AddProductPageArguments>(args);
        }
        final typedArgs =
            args as AddProductPageArguments ?? AddProductPageArguments();
        return MaterialPageRoute(
          builder: (_) => AddProductPage(
              price: typedArgs.price,
              name: typedArgs.name,
              id: typedArgs.id,
              imageUrl: typedArgs.imageUrl),
          settings: settings,
          fullscreenDialog: true,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

//**************************************************************************
// Arguments holder classes
//***************************************************************************

//AddProductPage arguments holder class
class AddProductPageArguments {
  final String price;
  final String name;
  final String id;
  final String imageUrl;
  AddProductPageArguments({this.price, this.name, this.id, this.imageUrl});
}
