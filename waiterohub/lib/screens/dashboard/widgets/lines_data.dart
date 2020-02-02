import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class LinesData {
  
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
}