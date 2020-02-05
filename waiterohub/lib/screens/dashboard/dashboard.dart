import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waitero/components/fade_in/fade_in.dart';
import 'package:waitero/components/loading/loading.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/screens/dashboard/widgets/chart_legend.dart';
import 'package:waitero/screens/dashboard/widgets/info_widget.dart';
import 'package:waitero/screens/dashboard/widgets/orders_chart.dart';
import 'package:waitero/services/database/orders_repo.dart';
import 'package:waitero/services/database/products_repo.dart';

/*
  ! The dashboard screen is where we display all of the data to the management.
  ? Kroz dashboard management moze vidjeti sve podatke.
*/

class DashboardPage extends StatefulWidget {
  const DashboardPage({
    Key key,
  }) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int todaysOrders;
  int monthlyOrders;

  @override
  Widget build(BuildContext context) {
    final OrdersRepository orders = Provider.of<OrdersRepository>(context);
    final ProductsRepository products =
        Provider.of<ProductsRepository>(context);

    Future<Map<String, dynamic>> _getData() async {
      return <String, dynamic>{
        'ordersToday': await orders.countOrders(OrderFetch.Today),
        'ordersMonthly': await orders.countOrders(OrderFetch.Monthly),
        'productCount': await products.countProducts(),
      };
    }

    return CustomScaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: _getData(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Dashboard',
                      style: TextStyle(
                        color: Color(0xFF20212C),
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Diodrum',
                        fontSize: 35.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const FadeIn(
                    delay: 0.33,
                    child: Text(
                      'Analytical Overview',
                      style: TextStyle(
                        color: Color(0xFF20212C),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                        fontFamily: 'Diodrum',
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0, top: 0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(35),
                        child: InfoWidgets(
                          snapshot: snapshot,
                        ),
                      ),
                    ),
                  ),
                  FadeIn(
                    delay: 0.6,
                    child: Row(
                      children: <Widget>[
                        const Text(
                          'Order Insight',
                          style: TextStyle(
                            color: Color(0xFF20212C),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.6,
                            fontFamily: 'Diodrum',
                            fontSize: 24.0,
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.33,
                        ),
                        const FadeIn(
                          child: ChartLegend(),
                          delay: 0.65,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: FadeIn(
                      child: OrdersChart(),
                      delay: 0.7,
                    ),
                  ),
                ],
              ),
            );
          }
          /*
        ! [loadingIndicator()] is a widget that builds the loading indicator.
        ? Kroz [loadingIndicator()] mozemo prikazati loading krug.
        */
          return const LoadingIndicator();
        },
      ),
    );
  }
}
