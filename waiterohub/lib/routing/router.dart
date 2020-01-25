import 'package:auto_route/auto_route_annotations.dart';
import 'package:waitero/screens/products/add_product/add_product.dart';
import 'package:waitero/screens/products/products.dart';
import 'package:waitero/screens/orders/orders.dart';
import 'package:waitero/screens/tables/tables.dart';

@AutoRouter(generateRouteList: true)
class $Router {
  @initial
  OrdersPage orders;
  ManageProductsPage manageProducts;
  TablesPage tables;
  @MaterialRoute(fullscreenDialog: true)
  AddProductPage addProduct;
}
