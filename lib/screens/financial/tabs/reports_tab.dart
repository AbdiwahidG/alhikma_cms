import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../config/theme.dart';
import '../../../services/financial_service.dart';
import '../../../utils/number_formatter.dart';
import '../../../widgets/dialogs/report_dialog.dart';

class ReportsTab extends StatelessWidget {
  const ReportsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    final financialService = Provider.of<FinancialService>(context);
    
    // Get report data
    final reportData = financialService.generateMonthlyReport(
      DateTime.now().subtract(const Duration(days: 180)),
      DateTime.now(),
    );
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Financial Reports',
                style: TextStyle(
                  color: textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const ReportDialog(),
                      );
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Generate Report'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          
          // Report filters
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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search reports...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: isLightTheme ? Colors.grey[100] : const Color(0xFF2A2A2A),
                    ),
                    style: TextStyle(color: textColor),
                  ),
                ),
                const SizedBox(width: 16),
                DropdownButton<String>(
                  value: 'All Reports',
                  items: const [
                    DropdownMenuItem(
                      value: 'All Reports',
                      child: Text('All Reports'),
                    ),
                    DropdownMenuItem(
                      value: 'Financial Summary',
                      child: Text('Financial Summary'),
                    ),
                    DropdownMenuItem(
                      value: 'Cash Flow Statement',
                      child: Text('Cash Flow Statement'),
                    ),
                    DropdownMenuItem(
                      value: 'Profit & Loss',
                      child: Text('Profit & Loss'),
                    ),
                    DropdownMenuItem(
                      value: 'Budget Analysis',
                      child: Text('Budget Analysis'),
                    ),
                  ],
                  onChanged: (value) {},
                  style: TextStyle(color: textColor),
                  dropdownColor: isLightTheme ? Colors.grey[100] : const Color(0xFF2A2A2A),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list),
                  label: const Text('Filter'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Report summary
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
                  'Monthly Financial Summary',
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
                      maxY: 35000000,
                      barTouchData: BarTouchData(
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: isLightTheme ? Colors.white : const Color(0xFF2A2A2A),
                          getTooltipItem: (group, groupIndex, rod, rodIndex) {
                            return BarTooltipItem(
                              '${NumberFormatter.formatCurrency(rod.toY)}\n${reportData[groupIndex]['month']}',
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
                              if (value.toInt() >= 0 && value.toInt() < reportData.length) {
                                return Text(
                                  reportData[value.toInt()]['month'],
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 12,
                                  ),
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 80,
                            getTitlesWidget: (value, meta) {
                              return Text(
                                NumberFormatter.formatCompactCurrency(value),
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: 12,
                                ),
                              );
                            },
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        horizontalInterval: 5000000,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: textColor.withOpacity(0.1),
                            strokeWidth: 1,
                          );
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: List.generate(
                        reportData.length,
                        (index) => BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: reportData[index]['total'].toDouble(),
                              color: AppTheme.primaryColor,
                              width: 20,
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Recent reports
          Text(
            'Recent Reports',
            style: TextStyle(
              color: textColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Container(
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
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Report Name',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Type',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Date Generated',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Period',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Actions',
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              rows: [
                _buildReportRow(
                  'Monthly Financial Summary - June 2023',
                  'Financial Summary',
                  DateTime.now().subtract(const Duration(days: 5)),
                  'June 1-30, 2023',
                  textColor,
                ),
                _buildReportRow(
                  'Cash Flow Statement - Q2 2023',
                  'Cash Flow Statement',
                  DateTime.now().subtract(const Duration(days: 15)),
                  'Apr 1-Jun 30, 2023',
                  textColor,
                ),
                _buildReportRow(
                  'Profit & Loss - May 2023',
                  'Profit & Loss',
                  DateTime.now().subtract(const Duration(days: 25)),
                  'May 1-31, 2023',
                  textColor,
                ),
                _buildReportRow(
                  'Budget Analysis - Q1 2023',
                  'Budget Analysis',
                  DateTime.now().subtract(const Duration(days: 45)),
                  'Jan 1-Mar 31, 2023',
                  textColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  DataRow _buildReportRow(
    String name,
    String type,
    DateTime dateGenerated,
    String period,
    Color textColor,
  ) {
    final dateFormat = DateFormat('MMM d, yyyy');
    
    return DataRow(
      cells: [
        DataCell(
          Text(
            name,
            style: TextStyle(color: textColor),
          ),
        ),
        DataCell(
          Text(
            type,
            style: TextStyle(color: textColor),
          ),
        ),
        DataCell(
          Text(
            dateFormat.format(dateGenerated),
            style: TextStyle(color: textColor),
          ),
        ),
        DataCell(
          Text(
            period,
            style: TextStyle(color: textColor),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {},
                tooltip: 'Download Report',
              ),
              IconButton(
                icon: const Icon(Icons.print),
                onPressed: () {},
                tooltip: 'Print Report',
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {},
                tooltip: 'Delete Report',
              ),
            ],
          ),
        ),
      ],
    );
  }
} 