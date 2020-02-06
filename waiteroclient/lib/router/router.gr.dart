// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/router_utils.dart';
import 'package:waiteroclient/screens/order/order.dart';
import 'package:waiteroclient/screens/cart/cart.dart';
import 'package:waiteroclient/screens/thanks/thanks.dart';

class Router {
  static const orderPage = '/';
  static const cartPage = '/cart-page';
  static const thanksPage = '/thanks-page';
  static const routes = [
    orderPage,
    cartPage,
    thanksPage,
  ];
  static GlobalKey<NavigatorState> get navigatorKey =>
      getNavigatorKey<Router>();
  static NavigatorState get navigator => navigatorKey.currentState;

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Router.orderPage:
        return MaterialPageRoute(
          builder: (_) => OrderPage(),
          settings: settings,
        );
      case Router.cartPage:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return MaterialPageRoute(
          builder: (_) => CartPage(key: typedArgs),
          settings: settings,
        );
      case Router.thanksPage:
        if (hasInvalidArgs<Key>(args)) {
          return misTypedArgsRoute<Key>(args);
        }
        final typedArgs = args as Key;
        return MaterialPageRoute(
          builder: (_) => ThanksPage(key: typedArgs),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}
