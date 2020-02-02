import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';
import 'package:waitero/services/database/orders_repo.dart';

class OrdersChart extends StatelessWidget {
  const OrdersChart({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<LineChartBarData> linesBar(AsyncSnapshot<List<FlSpot>> snapshot) {
      final LineChartBarData lineChartBarData1 = LineChartBarData(
        spots: snapshot.data,
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

    return FutureBuilder<List<FlSpot>>(
        future: Provider.of<OrdersRepository>(context)
            .calculateGraphDots(OrderFetch.Monthly),
        builder: (context, snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.5,
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
                maxY: 5,
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
