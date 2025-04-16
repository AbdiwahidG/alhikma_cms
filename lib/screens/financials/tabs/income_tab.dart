import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../config/theme.dart';
import '../../../utils/responsive_helper.dart';

class IncomeTab extends StatelessWidget {
  const IncomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    final isMobile = ResponsiveHelper.isMobile(context);
   // final isTablet = ResponsiveHelper.isTablet(context);
    
    // Hardcoded sample data
    final List<Map<String, dynamic>> incomeSources = [
      {
        'source': 'Client Payments',
        'amount': 125000,
        'percentage': 65,
        'trend': 'up',
        'color': Colors.blue,
      },
      {
        'source': 'Consulting',
        'amount': 45000,
        'percentage': 23,
        'trend': 'up',
        'color': Colors.green,
      },
      {
        'source': 'Equipment Rental',
        'amount': 15000,
        'percentage': 8,
        'trend': 'down',
        'color': Colors.orange,
      },
      {
        'source': 'Other',
        'amount': 10000,
        'percentage': 4,
        'trend': 'stable',
        'color': Colors.purple,
      },
    ];
    
    final List<Map<String, dynamic>> recentIncome = [
      {
        'id': 'INC-001',
        'date': DateTime(2023, 6, 15),
        'description': 'Client Payment - Project A',
        'amount': 25000,
        'category': 'Client Payments',
        'status': 'Completed',
      },
      {
        'id': 'INC-002',
        'date': DateTime(2023, 6, 13),
        'description': 'Client Payment - Project B',
        'amount': 18000,
        'category': 'Client Payments',
        'status': 'Completed',
      },
      {
        'id': 'INC-003',
        'date': DateTime(2023, 6, 11),
        'description': 'Client Payment - Project C',
        'amount': 32000,
        'category': 'Client Payments',
        'status': 'Completed',
      },
      {
        'id': 'INC-004',
        'date': DateTime(2023, 6, 10),
        'description': 'Consulting Services - Client X',
        'amount': 8500,
        'category': 'Consulting',
        'status': 'Completed',
      },
      {
        'id': 'INC-005',
        'date': DateTime(2023, 6, 8),
        'description': 'Equipment Rental - Project Y',
        'amount': 3500,
        'category': 'Equipment Rental',
        'status': 'Pending',
      },
    ];
    
    // Calculate total income
    final totalIncome = incomeSources.fold(0.0, (sum, source) => sum + source['amount']);
    
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary card
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
                  'Total Income',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${totalIncome.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'This Month',
                  style: TextStyle(
                    color: textColor.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          
          // Income sources and chart
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Income sources
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
                        'Income Sources',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...incomeSources.map((source) => _buildIncomeSourceItem(
                        source['source'],
                        source['amount'],
                        source['percentage'],
                        source['trend'],
                        source['color'],
                        textColor,
                      )).toList(),
                    ],
                  ),
                ),
              ),
              
              // Income chart
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
                          'Income Distribution',
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
                              sections: incomeSources.map((source) {
                                return PieChartSectionData(
                                  color: source['color'],
                                  value: source['percentage'].toDouble(),
                                  title: '${source['percentage']}%',
                                  radius: 100,
                                  titleStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 16,
                          runSpacing: 8,
                          children: incomeSources.map((source) => _buildLegendItem(
                            source['source'],
                            source['color'],
                          )).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 24),
          
          // Recent income
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
                      'Recent Income',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add new income
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Income'),
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
                      'Transaction ID',
                      'Date',
                      'Description',
                      'Category',
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
                    rows: recentIncome.map((income) => _buildIncomeRow(
                      income['id'],
                      DateFormat('dd MMM yyyy').format(income['date']),
                      income['description'],
                      income['category'],
                      income['amount'],
                      income['status'],
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

  Widget _buildIncomeSourceItem(
    String source,
    double amount,
    int percentage,
    String trend,
    Color color,
    Color textColor,
  ) {
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
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  source,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: color.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(trendIcon, size: 12, color: trendColor),
                  const SizedBox(width: 4),
                  Text(
                    '$percentage%',
                    style: TextStyle(
                      color: textColor.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
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

  DataRow _buildIncomeRow(
    String id,
    String date,
    String description,
    String category,
    double amount,
    String status,
    Color textColor,
  ) {
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

    return DataRow(
      cells: [
        DataCell(Text(id, style: TextStyle(color: textColor))),
        DataCell(Text(date, style: TextStyle(color: textColor))),
        DataCell(Text(description, style: TextStyle(color: textColor))),
        DataCell(Text(category, style: TextStyle(color: textColor))),
        DataCell(
          Text(
            '\$${amount.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.green,
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