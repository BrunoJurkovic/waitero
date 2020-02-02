import 'package:firebase/firebase.dart';
import 'package:flutter/widgets.dart';

class AnalyticsRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  AnalyticsRouteObserver({@required this.analytics});

  final Analytics analytics;

  void _sendRouteWithAnalytics(PageRoute<dynamic> route) {
    final String pageName = route.settings.name;
    analytics?.setCurrentScreen(pageName);
    print(pageName);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPush(route, previousRoute);
    if (route is PageRoute && previousRoute is PageRoute) {
      _sendRouteWithAnalytics(route);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    super.didPop(route, previousRoute);
    if (route is PageRoute && previousRoute is PageRoute) {
      _sendRouteWithAnalytics(route);
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute is PageRoute) {
      _sendRouteWithAnalytics(newRoute);
    }
  }
}
