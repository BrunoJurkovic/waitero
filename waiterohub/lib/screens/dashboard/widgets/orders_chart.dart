import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:waitero/services/database/orders_repo.dart';
import 'package:waitero/components/loading/loading.dart';

class OrdersChart extends StatelessWidget {
  const OrdersChart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<LineChartBarData> linesBar(
        AsyncSnapshot<Map<String, dynamic>> snapshot) {
      final LineChartBarData lineChartBarData1 = LineChartBarData(
        spots: (snapshot.hasData
            ? snapshot.data['daily']
            : <FlSpot>[const FlSpot(1, 1)]) as List<FlSpot>,
        isCurved: true,
        colors: const <Color>[
          Color(0xFFEF7198),
          Color(0xFFF296B7),
        ],
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: const BarAreaData(
          show: false,
        ),
      );
      final LineChartBarData lineChartBarData2 = LineChartBarData(
        spots: (snapshot.hasData
            ? snapshot.data['monthly']
            : <FlSpot>[const FlSpot(1, 1)]) as List<FlSpot>,
        isCurved: true,
        colors: <Color>[
          const Color(0xFF5EC999),
        ],
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: const BarAreaData(
          show: false,
          colors: <Color>[Color(0x00aa4cfc), Color(0xFF7EDDB9)],
        ),
      );
      return <LineChartBarData>[
        lineChartBarData1,
        lineChartBarData2,
      ];
    }

    Future<Map<String, dynamic>> _getFutures() async {
      return <String, dynamic>{
        'monthly': await Provider.of<OrdersRepository>(context, listen: false)
            .calculateGraphDots(OrderFetch.Monthly),
        'daily': await Provider.of<OrdersRepository>(context, listen: false)
            .calculateGraphDots(OrderFetch.Today),
        'maxY': await Provider.of<OrdersRepository>(context, listen: false)
            .countOrders(OrderFetch.Monthly),
      };
    }

    return FutureBuilder<Map<String, dynamic>>(
        future: _getFutures(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (!snapshot.hasData) {
            return const LoadingIndicator();
          }
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.7,
            child: LineChart(
              LineChartData(
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
                minX: 1,
                maxX: 31,
                maxY: (snapshot.data['maxY'] as int).toDouble(),
                minY: 0,
                lineBarsData: linesBar(snapshot),
                titlesData: const FlTitlesData(
                  leftTitles: SideTitles(showTitles: false),
                  bottomTitles: SideTitles(showTitles: false),
                ),
              ),
            ),
          );
        });
  }
}
