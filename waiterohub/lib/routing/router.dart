import 'package:auto_route/auto_route_annotations.dart';
import 'package:auto_route/transitions_builders.dart';
import 'package:waitero/screens/dashboard/dashboard.dart';
import 'package:waitero/screens/products/add_product/add_product.dart';
import 'package:waitero/screens/products/products.dart';
import 'package:waitero/screens/orders/orders.dart';
import 'package:waitero/screens/tables/table_details/table_details.dart';
import 'package:waitero/screens/tables/tables.dart';

@AutoRouter(generateRouteList: true)
class $Router {
  @CustomRoute(initial: true, transitionsBuilder: TransitionsBuilders.zoomIn)
  DashboardPage dashboard;
  @CustomRoute(transitionsBuilder: TransitionsBuilders.zoomIn)
  OrdersPage orders;
  @CustomRoute(transitionsBuilder: TransitionsBuilders.zoomIn)
  ManageProductsPage manageProducts;
  @CustomRoute(fullscreenDialog: true, transitionsBuilder: TransitionsBuilders.zoomIn)
  TablesPage tables;
  @MaterialRoute(fullscreenDialog: true)
  AddProductPage addProduct;
  @MaterialRoute(fullscreenDialog: true)
  TableDetails tableDetails;
}
