import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../config/theme.dart';

class LaborExpensesChart extends StatelessWidget {
  const LaborExpensesChart({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 200,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: isLightTheme ? Colors.grey[300]! : Colors.grey[800]!,
              strokeWidth: 1,
              dashArray: [5, 5],
            );
          },
        ),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                if (value.toInt() >= 0 && value.toInt() < months.length) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      months[value.toInt()],
                      style: TextStyle(
                        color: textColor,
                        fontSize: 12,
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
              interval: 1,
              reservedSize: 30,
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    '\$${value.toInt()}',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.right,
                  ),
                );
              },
              interval: 200,
              reservedSize: 40,
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        borderData: FlBorderData(show: false),
        minX: 0,
        maxX: 11,
        minY: 0,
        maxY: 1200,
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 800),
              FlSpot(1, 1000),
              FlSpot(2, 1100),
              FlSpot(3, 900),
              FlSpot(4, 950),
              FlSpot(5, 1050),
              FlSpot(6, 1240),
              FlSpot(7, 1000),
              FlSpot(8, 900),
              FlSpot(9, 950),
              FlSpot(10, 1100),
              FlSpot(11, 1000),
            ],
            isCurved: true,
            color: Colors.purple,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.purple.withOpacity(0.2),
            ),
          ),
          LineChartBarData(
            spots: const [
              FlSpot(0, 400),
              FlSpot(1, 300),
              FlSpot(2, 500),
              FlSpot(3, 700),
              FlSpot(4, 400),
              FlSpot(5, 350),
              FlSpot(6, 600),
              FlSpot(7, 800),
              FlSpot(8, 400),
              FlSpot(9, 300),
              FlSpot(10, 450),
              FlSpot(11, 500),
            ],
            isCurved: true,
            color: Colors.orange,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.orange.withOpacity(0.2),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: isLightTheme ? Colors.white : Colors.grey[800]!,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                final color = barSpot.bar.color;
                String text = '\$${flSpot.y.toStringAsFixed(2)}';
                
                if (barSpot.barIndex == 0) {
                  text = 'Weekly: $text';
                } else {
                  text = 'Prof: $text';
                }
                
                return LineTooltipItem(
                  text,
                  TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
} 