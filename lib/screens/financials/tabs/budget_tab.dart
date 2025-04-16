import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
//import 'package:intl/intl.dart';
import '../../../config/theme.dart';
import '../../../utils/responsive_helper.dart';

class BudgetTab extends StatelessWidget {
  const BudgetTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    
    // Hardcoded sample data
    final List<Map<String, dynamic>> budgetCategories = [
      {
        'category': 'Labor',
        'budget': 100000,
        'spent': 85000,
        'remaining': 15000,
        'percentage': 85,
        'status': 'on_track',
        'color': Colors.blue,
      },
      {
        'category': 'Materials',
        'budget': 50000,
        'spent': 35000,
        'remaining': 15000,
        'percentage': 70,
        'status': 'on_track',
        'color': Colors.green,
      },
      {
        'category': 'Equipment',
        'budget': 30000,
        'spent': 25000,
        'remaining': 5000,
        'percentage': 83,
        'status': 'on_track',
        'color': Colors.orange,
      },
      {
        'category': 'Marketing',
        'budget': 20000,
        'spent': 18000,
        'remaining': 2000,
        'percentage': 90,
        'status': 'warning',
        'color': Colors.purple,
      },
      {
        'category': 'Utilities',
        'budget': 15000,
        'spent': 15000,
        'remaining': 0,
        'percentage': 100,
        'status': 'exceeded',
        'color': Colors.red,
      },
      {
        'category': 'Other',
        'budget': 25000,
        'spent': 20000,
        'remaining': 5000,
        'percentage': 80,
        'status': 'on_track',
        'color': Colors.teal,
      },
    ];
    
    final List<Map<String, dynamic>> budgetHistory = [
      {
        'month': 'Jan',
        'budget': 180000,
        'spent': 165000,
        'variance': -15000,
      },
      {
        'month': 'Feb',
        'budget': 180000,
        'spent': 172000,
        'variance': -8000,
      },
      {
        'month': 'Mar',
        'budget': 180000,
        'spent': 178000,
        'variance': -2000,
      },
      {
        'month': 'Apr',
        'budget': 200000,
        'spent': 195000,
        'variance': -5000,
      },
      {
        'month': 'May',
        'budget': 200000,
        'spent': 205000,
        'variance': 5000,
      },
      {
        'month': 'Jun',
        'budget': 200000,
        'spent': 180000,
        'variance': 20000,
      },
    ];
    
    // Calculate total budget and spent
    final totalBudget = budgetCategories.fold(0.0, (sum, category) => sum + category['budget']);
    final totalSpent = budgetCategories.fold(0.0, (sum, category) => sum + category['spent']);
    final totalRemaining = totalBudget - totalSpent;
    final overallPercentage = (totalSpent / totalBudget) * 100;
    
    // Determine overall status
    String overallStatus;
    Color overallStatusColor;
    
    if (overallPercentage < 80) {
      overallStatus = 'On Track';
      overallStatusColor = Colors.green;
    } else if (overallPercentage < 95) {
      overallStatus = 'Warning';
      overallStatusColor = Colors.orange;
    } else {
      overallStatus = 'Exceeded';
      overallStatusColor = Colors.red;
    }
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary cards
          GridView.count(
            crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 4),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: isMobile ? 2.5 : 1.8,
            children: [
              _buildSummaryCard(
                'Total Budget',
                '\$${totalBudget.toStringAsFixed(2)}',
                'this month',
                Icons.account_balance_wallet,
                AppTheme.primaryColor,
                isLightTheme,
                textColor,
              ),
              _buildSummaryCard(
                'Total Spent',
                '\$${totalSpent.toStringAsFixed(2)}',
                'this month',
                Icons.payments,
                Colors.orange,
                isLightTheme,
                textColor,
              ),
              _buildSummaryCard(
                'Remaining',
                '\$${totalRemaining.toStringAsFixed(2)}',
                'this month',
                Icons.savings,
                Colors.green,
                isLightTheme,
                textColor,
              ),
              _buildSummaryCard(
                'Status',
                overallStatus,
                '${overallPercentage.toStringAsFixed(1)}% used',
                Icons.info,
                overallStatusColor,
                isLightTheme,
                textColor,
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Budget categories and chart
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Budget categories
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
                        'Budget Categories',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...budgetCategories.map((category) => _buildBudgetCategoryItem(
                        category['category'],
                        category['budget'],
                        category['spent'],
                        category['remaining'],
                        category['percentage'],
                        category['status'],
                        category['color'],
                        textColor,
                      )).toList(),
                    ],
                  ),
                ),
              ),
              
              // Budget chart
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
                        Text(
                          'Budget vs. Actual',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 300,
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: budgetHistory.map((item) => 
                                item['budget'] > item['spent'] ? item['budget'] : item['spent']
                              ).reduce((a, b) => a > b ? a : b) * 1.2,
                              barTouchData: BarTouchData(
                                enabled: true,
                                touchTooltipData: BarTouchTooltipData(
                                  tooltipBgColor: isLightTheme ? Colors.white : Colors.grey[800]!,
                                  getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                    final item = budgetHistory[groupIndex];
                                    return BarTooltipItem(
                                      '${item['month']}\nBudget: \$${item['budget']}\nSpent: \$${item['spent']}',
                                      TextStyle(
                                        color: isLightTheme ? Colors.black : Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
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
                                          budgetHistory[value.toInt()]['month'],
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
                              barGroups: budgetHistory.asMap().entries.map((entry) {
                                final index = entry.key;
                                final item = entry.value;
                                return BarChartGroupData(
                                  x: index,
                                  barRods: [
                                    BarChartRodData(
                                      toY: item['budget'],
                                      color: AppTheme.primaryColor.withOpacity(0.5),
                                      width: 20,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(4),
                                      ),
                                    ),
                                    BarChartRodData(
                                      toY: item['spent'],
                                      color: item['variance'] >= 0 ? Colors.green : Colors.red,
                                      width: 20,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(4),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                              gridData: FlGridData(
                                show: true,
                                drawVerticalLine: false,
                                horizontalInterval: 50000,
                                getDrawingHorizontalLine: (value) {
                                  return FlLine(
                                    color: Colors.grey.withOpacity(0.2),
                                    strokeWidth: 1,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildLegendItem('Budget', AppTheme.primaryColor.withOpacity(0.5)),
                            const SizedBox(width: 24),
                            _buildLegendItem('Actual', Colors.green),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 24),
          
          // Budget variance
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
                      'Budget Variance',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Create new budget
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Create Budget'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                      ),
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
                      'Month',
                      'Budget',
                      'Actual',
                      'Variance',
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
                    rows: budgetHistory.map((item) => _buildBudgetVarianceRow(
                      item['month'],
                      item['budget'],
                      item['spent'],
                      item['variance'],
                      textColor,
                    )).toList(),
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

  Widget _buildBudgetCategoryItem(
    String category,
    double budget,
    double spent,
    double remaining,
    int percentage,
    String status,
    Color color,
    Color textColor,
  ) {
    Color statusColor;
    String statusText;
    
    switch (status) {
      case 'on_track':
        statusColor = Colors.green;
        statusText = 'On Track';
        break;
      case 'warning':
        statusColor = Colors.orange;
        statusText = 'Warning';
        break;
      case 'exceeded':
        statusColor = Colors.red;
        statusText = 'Exceeded';
        break;
      default:
        statusColor = Colors.grey;
        statusText = 'Unknown';
    }
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                category,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: percentage / 100,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Budget: \$${budget.toStringAsFixed(2)}',
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                ),
              ),
              Text(
                'Spent: \$${spent.toStringAsFixed(2)}',
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                ),
              ),
              Text(
                'Remaining: \$${remaining.toStringAsFixed(2)}',
                style: TextStyle(
                  color: remaining >= 0 ? Colors.green : Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
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

  DataRow _buildBudgetVarianceRow(
    String month,
    double budget,
    double actual,
    double variance,
    Color textColor,
  ) {
    final isPositive = variance >= 0;
    final statusColor = isPositive ? Colors.green : Colors.red;
    final statusText = isPositive ? 'Under Budget' : 'Over Budget';
    
    return DataRow(
      cells: [
        DataCell(Text(month, style: TextStyle(color: textColor))),
        DataCell(Text('\$${budget.toStringAsFixed(2)}', style: TextStyle(color: textColor))),
        DataCell(Text('\$${actual.toStringAsFixed(2)}', style: TextStyle(color: textColor))),
        DataCell(
          Text(
            '\$${variance.abs().toStringAsFixed(2)}',
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              statusText,
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