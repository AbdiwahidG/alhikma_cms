import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../config/theme.dart';
import '../../../utils/responsive_helper.dart';

class ReportsTab extends StatelessWidget {
  const ReportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    
    // Hardcoded sample data
    final List<Map<String, dynamic>> financialMetrics = [
      {
        'metric': 'Revenue Growth',
        'value': '+12.5%',
        'trend': 'up',
        'icon': Icons.trending_up,
        'color': Colors.green,
      },
      {
        'metric': 'Profit Margin',
        'value': '18.3%',
        'trend': 'up',
        'icon': Icons.analytics,
        'color': Colors.blue,
      },
      {
        'metric': 'Operating Expenses',
        'value': '-5.2%',
        'trend': 'down',
        'icon': Icons.money_off,
        'color': Colors.orange,
      },
      {
        'metric': 'Cash Flow',
        'value': '+8.7%',
        'trend': 'up',
        'icon': Icons.account_balance,
        'color': Colors.purple,
      },
    ];
    
    final List<Map<String, dynamic>> monthlyRevenue = [
      {'month': 'Jan', 'revenue': 120000, 'expenses': 95000, 'profit': 25000},
      {'month': 'Feb', 'revenue': 135000, 'expenses': 98000, 'profit': 37000},
      {'month': 'Mar', 'revenue': 128000, 'expenses': 102000, 'profit': 26000},
      {'month': 'Apr', 'revenue': 142000, 'expenses': 105000, 'profit': 37000},
      {'month': 'May', 'revenue': 155000, 'expenses': 110000, 'profit': 45000},
      {'month': 'Jun', 'revenue': 168000, 'expenses': 115000, 'profit': 53000},
    ];
    
    final List<Map<String, dynamic>> expenseBreakdown = [
      {'category': 'Labor', 'amount': 85000, 'percentage': 45},
      {'category': 'Materials', 'amount': 35000, 'percentage': 18},
      {'category': 'Equipment', 'amount': 25000, 'percentage': 13},
      {'category': 'Marketing', 'amount': 18000, 'percentage': 10},
      {'category': 'Utilities', 'amount': 15000, 'percentage': 8},
      {'category': 'Other', 'amount': 12000, 'percentage': 6},
    ];
    
    final List<Map<String, dynamic>> recentReports = [
      {
        'title': 'Q2 Financial Summary',
        'date': DateTime(2023, 6, 30),
        'type': 'Quarterly',
        'status': 'Completed',
      },
      {
        'title': 'Monthly Budget Analysis',
        'date': DateTime(2023, 6, 15),
        'type': 'Monthly',
        'status': 'Completed',
      },
      {
        'title': 'Cash Flow Statement',
        'date': DateTime(2023, 6, 10),
        'type': 'Monthly',
        'status': 'Completed',
      },
      {
        'title': 'Expense Breakdown',
        'date': DateTime(2023, 6, 5),
        'type': 'Monthly',
        'status': 'Completed',
      },
      {
        'title': 'Revenue Analysis',
        'date': DateTime(2023, 6, 1),
        'type': 'Monthly',
        'status': 'Completed',
      },
    ];
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Financial metrics
          GridView.count(
            crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: isMobile ? 2.5 : 1.8,
            children: financialMetrics.map((metric) => _buildMetricCard(
              metric['metric'],
              metric['value'],
              metric['trend'],
              metric['icon'],
              metric['color'],
              isLightTheme,
              textColor,
            )).toList(),
          ),
          const SizedBox(height: 24),
          
          // Revenue chart
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
                  'Revenue & Expenses',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval: 30000,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.grey.withOpacity(0.2),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const style = TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              );
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                child: Text(
                                  monthlyRevenue[value.toInt()]['month'],
                                  style: style,
                                ),
                              );
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 60,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                '\$${value.toInt()}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      lineBarsData: [
                        // Revenue line
                        LineChartBarData(
                          spots: monthlyRevenue.asMap().entries.map((entry) {
                            return FlSpot(entry.key.toDouble(), entry.value['revenue'].toDouble());
                          }).toList(),
                          isCurved: true,
                          color: AppTheme.primaryColor,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: true),
                          belowBarData: BarAreaData(
                            show: true,
                            color: AppTheme.primaryColor.withOpacity(0.1),
                          ),
                        ),
                        // Expenses line
                        LineChartBarData(
                          spots: monthlyRevenue.asMap().entries.map((entry) {
                            return FlSpot(entry.key.toDouble(), entry.value['expenses'].toDouble());
                          }).toList(),
                          isCurved: true,
                          color: Colors.red,
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: const FlDotData(show: true),
                          belowBarData: BarAreaData(
                            show: true,
                            color: Colors.red.withOpacity(0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLegendItem('Revenue', AppTheme.primaryColor),
                    const SizedBox(width: 24),
                    _buildLegendItem('Expenses', Colors.red),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Expense breakdown and recent reports
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expense breakdown
              Expanded(
                flex: isMobile ? 1 : 2,
                child: Container(
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
                        'Expense Breakdown',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...expenseBreakdown.map((expense) => _buildExpenseItem(
                        expense['category'],
                        expense['amount'],
                        expense['percentage'],
                        textColor,
                      )).toList(),
                    ],
                  ),
                ),
              ),
              
              // Recent reports
              if (!isMobile) ...[
                const SizedBox(width: 16),
                Expanded(
                  child: Container(
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
                              'Recent Reports',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () {
                                // View all reports
                              },
                              icon: const Icon(Icons.visibility),
                              label: const Text('View All'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ...recentReports.map((report) => _buildReportItem(
                          report['title'],
                          DateFormat('dd MMM yyyy').format(report['date']),
                          report['type'],
                          report['status'],
                          textColor,
                        )).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 24),
          
          // Report generation
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
                  'Generate Reports',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _buildReportTypeCard(
                      'Financial Summary',
                      'Comprehensive financial overview',
                      Icons.summarize,
                      AppTheme.primaryColor,
                      isLightTheme,
                      textColor,
                    ),
                    _buildReportTypeCard(
                      'Cash Flow Statement',
                      'Track cash inflows and outflows',
                      Icons.account_balance,
                      Colors.blue,
                      isLightTheme,
                      textColor,
                    ),
                    _buildReportTypeCard(
                      'Profit & Loss',
                      'Revenue and expense analysis',
                      Icons.analytics,
                      Colors.green,
                      isLightTheme,
                      textColor,
                    ),
                    _buildReportTypeCard(
                      'Budget Analysis',
                      'Budget performance metrics',
                      Icons.account_balance_wallet,
                      Colors.orange,
                      isLightTheme,
                      textColor,
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

  Widget _buildMetricCard(String title, String value, String trend,
      IconData icon, Color color, bool isLightTheme, Color textColor) {
    IconData trendIcon;
    Color trendColor;
    
    switch (trend) {
      case 'up':
        trendIcon = Icons.arrow_upward;
        trendColor = Colors.green;
        break;
      case 'down':
        trendIcon = Icons.arrow_downward;
        trendColor = Colors.red;
        break;
      default:
        trendIcon = Icons.remove;
        trendColor = Colors.grey;
    }
    
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
          Row(
            children: [
              Text(
                value,
                style: TextStyle(
                  color: textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Icon(trendIcon, color: trendColor, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildExpenseItem(String category, double amount, int percentage, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
          ),
          const SizedBox(height: 4),
          Text(
            '$percentage%',
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReportItem(String title, String date, String type, String status, Color textColor) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'completed':
        statusColor = Colors.green;
        break;
      case 'pending':
        statusColor = Colors.orange;
        break;
      case 'failed':
        statusColor = Colors.red;
        break;
      default:
        statusColor = Colors.grey;
    }
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.description,
              color: AppTheme.primaryColor,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        color: textColor.withOpacity(0.7),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
        ],
      ),
    );
  }

  Widget _buildReportTypeCard(String title, String description,
      IconData icon, Color color, bool isLightTheme, Color textColor) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: TextStyle(
              color: textColor.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Generate report
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 36),
            ),
            child: const Text('Generate'),
          ),
        ],
      ),
    );
  }
} 