import 'package:flutter/material.dart';
import 'package:waitero/components/nav_rail/nav_rail.dart';
import 'package:waitero/routing/router.gr.dart';

class CustomRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final NavRail rail = const NavRail();

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute is PageRoute && route is PageRoute) {
      rail.selectedIndex = Router.routes.indexOf(previousRoute.settings.name);
    }
  }
}
