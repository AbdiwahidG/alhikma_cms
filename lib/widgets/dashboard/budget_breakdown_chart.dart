import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BudgetBreakdownChart extends StatelessWidget {
  const BudgetBreakdownChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Budget breakdown'),
                  const SizedBox(height: 4),
                  Text(
                    'Based on usage',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              // IconButton(
              //   icon: const Icon(Icons.more_vert),
              //   onPressed: () {},
              // ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 60,
                      sections: [
                        PieChartSectionData(
                          value: 46,
                          color: const Color(0xFFFF6B4A),
                          title: '',
                          radius: 20,
                        ),
                        PieChartSectionData(
                          value: 34,
                          color: const Color(0xFF00BFA5),
                          title: '',
                          radius: 20,
                        ),
                        PieChartSectionData(
                          value: 20,
                          color: Colors.blue,
                          title: '',
                          radius: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLegendItem(
                      'Materials',
                      const Color(0xFFFF6B4A),
                      '46%',
                    ),
                    const SizedBox(height: 16),
                    _buildLegendItem(
                      'Labor',
                      const Color(0xFF00BFA5),
                      '600',
                    ),
                    const SizedBox(height: 16),
                    _buildLegendItem(
                      'Miscellaneous',
                      Colors.blue,
                      '200',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
} 