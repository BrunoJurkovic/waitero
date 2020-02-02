import 'package:auto_route/auto_route_annotations.dart';
import 'package:auto_route/transitions_builders.dart';
import 'package:waitero/screens/dashboard/dashboard.dart';
import 'package:waitero/screens/products/add_product/add_product.dart';
import 'package:waitero/screens/products/products.dart';
import 'package:waitero/screens/orders/orders.dart';
import 'package:waitero/screens/tables/tables.dart';

/*
  ! We use a package called 'auto_route' for our routes and the logic behing them.
  ? Koristimo package koji se zove 'auto_route' koji upravlja svim tranzicijama izmedu ekrana.
*/

@AutoRouter(generateRouteList: true)
/*
  ! The package generates the code to use in our transitions, and we can give the generator paramaters such
  ! as 'inital', which marks the page as home, and 'transitionBuilder' for custom animations between screens. 
  ? Package koji smo naveli generira kod koji se koristi pri tranziciji, takoder mozemo dati generatoru parametre
  ? kao sto su 'inital', koji oznaci stranicu kao pocetnu, i 'transitionBuilder', koji animira promjenu izmedu ekrana.
*/
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
}
