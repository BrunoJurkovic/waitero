import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';
import 'package:waitero/components/scaffold/custom_scaffold.dart';
import 'package:waitero/providers/order.dart';
import 'package:waitero/screens/dashboard/widgets/data_container.dart';
import 'package:waitero/services/database/orders_repo.dart';

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


    List<LineChartBarData> linesBar() {
      const LineChartBarData lineChartBarData1 = LineChartBarData(
        spots: <FlSpot>[
          FlSpot(1, 1),
          FlSpot(3, 1.5),
          FlSpot(5, 1.4),
          FlSpot(7, 3.4),
          FlSpot(10, 2),
          FlSpot(12, 2.2),
          FlSpot(13, 1.8),
        ],
        isCurved: true,
        colors: <Color>[
          Color(0xFFEF7198),
          Color(0xFFF296B7),
        ],
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
      );
      const LineChartBarData lineChartBarData2 = LineChartBarData(
        spots: <FlSpot>[
          FlSpot(1, 1),
          FlSpot(3, 2.8),
          FlSpot(7, 1.2),
          FlSpot(10, 2.8),
          FlSpot(12, 2.6),
          FlSpot(13, 3.9),
        ],
        isCurved: true,
        colors: <Color>[
          Color(0xFF5EC999),
        ],
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: false,
          colors: <Color>[Color(0x00aa4cfc), Color(0xFF7EDDB9)],
        ),
      );
      return <LineChartBarData>[
        lineChartBarData1,
        lineChartBarData2,
      ];
    }

    LineChartData lineChartData() {
      return LineChartData(
        lineTouchData: LineTouchData(
          touchTooltipData: const LineTouchTooltipData(
            tooltipBgColor: Colors.black,
            tooltipRoundedRadius: 10,
          ),
          touchCallback: (LineTouchResponse touchResponse) {
            print(touchResponse.toString());
          },
          handleBuiltInTouches: true,
        ),
        gridData: const FlGridData(
          show: false,
        ),
        borderData: FlBorderData(
          show: false,
        ),
        minX: 0,
        maxX: 14,
        maxY: 4,
        minY: 0,
        lineBarsData: linesBar(),
        titlesData: const FlTitlesData(
          leftTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(showTitles: false),
        ),
      );
    }

    return CustomScaffold(
      body: FutureBuilder<dynamic>(
        future: Future.wait<dynamic>([
          orders.countOrders(OrderFetch.Today),
          orders.countOrders(OrderFetch.Monthly),
        ]),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
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
                Text(
                  'Analytical Overview',
                  style: TextStyle(
                    color: const Color(0xFF20212C),
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                    fontFamily: 'Diodrum',
                    fontSize: 24.0,
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
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const <Widget>[
                              DataContainer(
                                color1: Color(0xFFEF7198),
                                color2: Color(0xFFF296B7),
                                bottomText: '157',
                                topText: 'NEW ORDERS',
                                sideText: 'orders',
                                icon: Icon(
                                  OMIcons.showChart,
                                  size: 60,
                                  color: Colors.white54,
                                ),
                              ),
                              DataContainer(
                                color1: Color(0xFFBA82FF),
                                color2: Color(0xFFD0A3FF),
                                bottomText: '23',
                                topText: 'MENU ITEMS',
                                sideText: 'items',
                                icon: Icon(
                                  OMIcons.restaurantMenu,
                                  size: 60,
                                  color: Colors.white54,
                                ),
                              ),
                              DataContainer(
                                color1: Color(0xFF5EC999),
                                color2: Color(0xFF7EDDB9),
                                bottomText: '2.300',
                                topText: 'MONTHLY ORDERS',
                                sideText: 'orders',
                                icon: Icon(
                                  OMIcons.barChart,
                                  size: 60,
                                  color: Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Order Insight',
                      style: TextStyle(
                        color: const Color(0xFF20212C),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                        fontFamily: 'Diodrum',
                        fontSize: 24.0,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.16,
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFEF7198),
                            shape: BoxShape.circle,
                          ),
                          height: 12,
                          width: 12,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Today's orders",
                          style: TextStyle(
                            color: Colors.grey[600],
                            letterSpacing: 0.7,
                            fontFamily: 'Diodrum',
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFF5EC999),
                            shape: BoxShape.circle,
                          ),
                          height: 12,
                          width: 12,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Monthly Orders',
                          style: TextStyle(
                            color: Colors.grey[600],
                            letterSpacing: 0.7,
                            fontFamily: 'Diodrum',
                            fontSize: 14.0,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: LineChart(
                    lineChartData(),
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
