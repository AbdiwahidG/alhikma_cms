import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../config/theme.dart';
import '../../../utils/responsive_helper.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    
    // Hardcoded sample data
    final Map<String, double> monthlyData = {
      'Jan': 125000,
      'Feb': 142000,
      'Mar': 138000,
      'Apr': 156000,
      'May': 168000,
      'Jun': 175000,
    };
    
    final List<Map<String, dynamic>> recentTransactions = [
      {
        'id': 'TRX-001',
        'date': DateTime(2023, 6, 15),
        'description': 'Client Payment - Project A',
        'amount': 25000,
        'type': 'income',
        'category': 'Client Payments',
      },
      {
        'id': 'TRX-002',
        'date': DateTime(2023, 6, 14),
        'description': 'Office Supplies',
        'amount': 1200,
        'type': 'expense',
        'category': 'Supplies',
      },
      {
        'id': 'TRX-003',
        'date': DateTime(2023, 6, 13),
        'description': 'Client Payment - Project B',
        'amount': 18000,
        'type': 'income',
        'category': 'Client Payments',
      },
      {
        'id': 'TRX-004',
        'date': DateTime(2023, 6, 12),
        'description': 'Utility Bill',
        'amount': 850,
        'type': 'expense',
        'category': 'Utilities',
      },
      {
        'id': 'TRX-005',
        'date': DateTime(2023, 6, 11),
        'description': 'Client Payment - Project C',
        'amount': 32000,
        'type': 'income',
        'category': 'Client Payments',
      },
    ];
    
    // Calculate summary statistics
    final totalIncome = recentTransactions
        .where((t) => t['type'] == 'income')
        .fold(0.0, (sum, t) => sum + t['amount']);
    
    final totalExpenses = recentTransactions
        .where((t) => t['type'] == 'expense')
        .fold(0.0, (sum, t) => sum + t['amount']);
    
    final netIncome = totalIncome - totalExpenses;
    final profitMargin = totalIncome > 0 ? (netIncome / totalIncome) * 100 : 0;
    
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
                'Total Income',
                '\$${totalIncome.toStringAsFixed(2)}',
                'this month',
                Icons.arrow_upward,
                Colors.green,
                isLightTheme,
                textColor,
              ),
              _buildSummaryCard(
                'Total Expenses',
                '\$${totalExpenses.toStringAsFixed(2)}',
                'this month',
                Icons.arrow_downward,
                Colors.red,
                isLightTheme,
                textColor,
              ),
              _buildSummaryCard(
                'Net Income',
                '\$${netIncome.toStringAsFixed(2)}',
                'this month',
                Icons.account_balance,
                AppTheme.primaryColor,
                isLightTheme,
                textColor,
              ),
              _buildSummaryCard(
                'Profit Margin',
                '${profitMargin.toStringAsFixed(1)}%',
                'this month',
                Icons.trending_up,
                AppTheme.secondaryColor,
                isLightTheme,
                textColor,
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Charts
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Income vs Expenses Chart
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
                        'Income vs Expenses',
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
                            maxY: monthlyData.values.reduce((a, b) => a > b ? a : b) * 1.2,
                            barTouchData: BarTouchData(
                              enabled: true,
                              touchTooltipData: BarTouchTooltipData(
                                tooltipBgColor: isLightTheme ? Colors.white : Colors.grey[800]!,
                                getTooltipItem: (group, groupIndex, rod, rodIndex) {
                                  return BarTooltipItem(
                                    '${monthlyData.keys.elementAt(groupIndex)}\n\$${rod.toY.toStringAsFixed(0)}',
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
                                        monthlyData.keys.elementAt(value.toInt()),
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
                            barGroups: monthlyData.entries.map((entry) {
                              return BarChartGroupData(
                                x: monthlyData.keys.toList().indexOf(entry.key),
                                barRods: [
                                  BarChartRodData(
                                    toY: entry.value,
                                    color: AppTheme.primaryColor,
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
                    ],
                  ),
                ),
              ),
              
              // Cash Flow Chart
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
                          'Cash Flow',
                          style: TextStyle(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 300,
                          child: PieChart(
                            PieChartData(
                              sectionsSpace: 2,
                              centerSpaceRadius: 40,
                              sections: [
                                PieChartSectionData(
                                  color: Colors.green,
                                  value: 65,
                                  title: '65%',
                                  radius: 100,
                                  titleStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                PieChartSectionData(
                                  color: Colors.red,
                                  value: 35,
                                  title: '35%',
                                  radius: 100,
                                  titleStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
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
                            _buildLegendItem('Income', Colors.green),
                            const SizedBox(width: 24),
                            _buildLegendItem('Expenses', Colors.red),
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
          
          // Recent Transactions
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
                      'Recent Transactions',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigate to all transactions
                      },
                      child: const Text('View All'),
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
                      'Transaction ID',
                      'Date',
                      'Description',
                      'Category',
                      'Amount',
                      'Type',
                    ].map((header) => DataColumn(
                      label: Text(
                        header,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )).toList(),
                    rows: recentTransactions.map((transaction) => _buildTransactionRow(
                      transaction['id'],
                      DateFormat('dd MMM yyyy').format(transaction['date']),
                      transaction['description'],
                      transaction['category'],
                      transaction['amount'],
                      transaction['type'],
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

  Widget _buildLegendItem(String label, Color color) {
    return Row(
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

  DataRow _buildTransactionRow(
    String id,
    String date,
    String description,
    String category,
    double amount,
    String type,
    Color textColor,
  ) {
    final isIncome = type == 'income';
    
    return DataRow(
      cells: [
        DataCell(Text(id, style: TextStyle(color: textColor))),
        DataCell(Text(date, style: TextStyle(color: textColor))),
        DataCell(Text(description, style: TextStyle(color: textColor))),
        DataCell(Text(category, style: TextStyle(color: textColor))),
        DataCell(
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: TextStyle(
              color: isIncome ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: (isIncome ? Colors.green : Colors.red).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              type.toUpperCase(),
              style: TextStyle(
                color: isIncome ? Colors.green : Colors.red,
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