import 'package:flutter/material.dart';
import 'package:alhikma_cms/config/theme.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';
import 'package:fl_chart/fl_chart.dart';

class SalariesTab extends StatelessWidget {
  const SalariesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Salary Summary Cards
          GridView.count(
            crossAxisCount: isMobile ? 2 : 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: isMobile ? 1.5 : 1.8,
            children: [
              _buildSummaryCard(
                'Total Payroll',
                '\$125,000',
                'this month',
                Icons.account_balance_wallet,
                AppTheme.primaryColor,
                isLightTheme,
                textColor,
              ),
              _buildSummaryCard(
                'Average Salary',
                '\$4,500',
                'per employee',
                Icons.attach_money,
                AppTheme.secondaryColor,
                isLightTheme,
                textColor,
              ),
              _buildSummaryCard(
                'Pending Payments',
                '\$15,000',
                '5 employees',
                Icons.warning,
                AppTheme.warningColor,
                isLightTheme,
                textColor,
              ),
              _buildSummaryCard(
                'Last Payout',
                '\$112,000',
                'on 25 Jul 2023',
                Icons.payment,
                AppTheme.successColor,
                isLightTheme,
                textColor,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Salary Trends Chart
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Salary Trends',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 300,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 20,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: isLightTheme ? Colors.grey[300]! : Colors.grey[800]!,
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                              if (value < 0 || value >= months.length) {
                                return const Text('');
                              }
                              return Text(
                                months[value.toInt()],
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '\$${value.toInt()}k',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 12,
                                ),
                              );
                            },
                            interval: 20,
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      minX: 0,
                      maxX: 5,
                      minY: 0,
                      maxY: 140,
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 100),
                            FlSpot(1, 110),
                            FlSpot(2, 105),
                            FlSpot(3, 115),
                            FlSpot(4, 125),
                            FlSpot(5, 120),
                          ],
                          isCurved: true,
                          color: AppTheme.primaryColor,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(show: false),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppTheme.primaryColor.withOpacity(0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Payment History
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Payment History',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                      label: const Text('Export'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                      isLightTheme ? Colors.grey[100] : const Color(0xFF252525),
                    ),
                    columns: [
                      'Payment ID',
                      'Date',
                      'Employee',
                      'Type',
                      'Amount',
                      'Status',
                    ].map((header) => DataColumn(
                      label: Text(
                        header,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )).toList(),
                    rows: [
                      _buildPaymentRow(
                        'PAY-2023-001',
                        '25 Jul 2023',
                        'John Smith',
                        'Salary',
                        4500,
                        'Completed',
                        textColor,
                      ),
                      _buildPaymentRow(
                        'PAY-2023-002',
                        '25 Jul 2023',
                        'Alice Johnson',
                        'Bonus',
                        1000,
                        'Completed',
                        textColor,
                      ),
                      _buildPaymentRow(
                        'PAY-2023-003',
                        '26 Jul 2023',
                        'Bob Wilson',
                        'Salary',
                        5000,
                        'Pending',
                        textColor,
                      ),
                      _buildPaymentRow(
                        'PAY-2023-004',
                        '26 Jul 2023',
                        'Emma Davis',
                        'Overtime',
                        800,
                        'Processing',
                        textColor,
                      ),
                      _buildPaymentRow(
                        'PAY-2023-005',
                        '27 Jul 2023',
                        'Mike Brown',
                        'Salary',
                        4800,
                        'Failed',
                        textColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, String subtitle,
      IconData icon, Color color, bool isLightTheme, Color textColor) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: color,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildPaymentRow(
    String id,
    String date,
    String employee,
    String type,
    double amount,
    String status,
    Color textColor,
  ) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'completed':
        statusColor = AppTheme.successColor;
        break;
      case 'pending':
        statusColor = AppTheme.warningColor;
        break;
      case 'processing':
        statusColor = AppTheme.infoColor;
        break;
      case 'failed':
        statusColor = AppTheme.errorColor;
        break;
      default:
        statusColor = Colors.grey;
    }

    return DataRow(
      cells: [
        DataCell(Text(id, style: TextStyle(color: textColor))),
        DataCell(Text(date, style: TextStyle(color: textColor))),
        DataCell(Text(employee, style: TextStyle(color: textColor))),
        DataCell(Text(type, style: TextStyle(color: textColor))),
        DataCell(Text('\$${amount.toStringAsFixed(2)}', style: TextStyle(color: textColor))),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
} 