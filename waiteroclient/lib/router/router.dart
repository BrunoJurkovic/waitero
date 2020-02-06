import 'package:auto_route/auto_route_annotations.dart';
import 'package:waiteroclient/screens/cart/cart.dart';
import 'package:waiteroclient/screens/order/order.dart';
import 'package:waiteroclient/screens/thanks/thanks.dart';

@AutoRouter(generateRouteList: true)
class $Router {
  @initial
  OrderPage orderPage;
  CartPage cartPage;
  ThanksPage thanksPage;
}