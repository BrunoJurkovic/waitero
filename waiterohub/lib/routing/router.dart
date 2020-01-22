import 'package:auto_route/auto_route_annotations.dart';
import 'package:waitero/screens/products/products.dart';
import 'package:waitero/screens/orders/orders.dart';

@AutoRouter(generateRouteList: true)
class $Router {
  @initial
  OrdersPage orders;
  ManageProductsPage manageProducts;
}
