import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../config/theme.dart';
import '../../../utils/responsive_helper.dart';

class ExpensesTab extends StatelessWidget {
  const ExpensesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    final isMobile = ResponsiveHelper.isMobile(context);
   // final isTablet = ResponsiveHelper.isTablet(context);
    
    // Hardcoded sample data
    final List<Map<String, dynamic>> expenseCategories = [
      {
        'category': 'Labor',
        'amount': 85000,
        'percentage': 45,
        'trend': 'up',
        'color': Colors.blue,
      },
      {
        'category': 'Materials',
        'amount': 35000,
        'percentage': 18,
        'trend': 'down',
        'color': Colors.green,
      },
      {
        'category': 'Equipment',
        'amount': 25000,
        'percentage': 13,
        'trend': 'stable',
        'color': Colors.orange,
      },
      {
        'category': 'Utilities',
        'amount': 15000,
        'percentage': 8,
        'trend': 'up',
        'color': Colors.purple,
      },
      {
        'category': 'Other',
        'amount': 20000,
        'percentage': 16,
        'trend': 'up',
        'color': Colors.red,
      },
    ];
    
    final List<Map<String, dynamic>> recentExpenses = [
      {
        'id': 'EXP-001',
        'date': DateTime(2023, 6, 14),
        'description': 'Office Supplies',
        'amount': 1200,
        'category': 'Other',
        'status': 'Completed',
      },
      {
        'id': 'EXP-002',
        'date': DateTime(2023, 6, 12),
        'description': 'Utility Bill',
        'amount': 850,
        'category': 'Utilities',
        'status': 'Completed',
      },
      {
        'id': 'EXP-003',
        'date': DateTime(2023, 6, 10),
        'description': 'Construction Materials',
        'amount': 12500,
        'category': 'Materials',
        'status': 'Completed',
      },
      {
        'id': 'EXP-004',
        'date': DateTime(2023, 6, 8),
        'description': 'Equipment Rental',
        'amount': 3500,
        'category': 'Equipment',
        'status': 'Pending',
      },
      {
        'id': 'EXP-005',
        'date': DateTime(2023, 6, 5),
        'description': 'Labor Payment',
        'amount': 8500,
        'category': 'Labor',
        'status': 'Completed',
      },
    ];
    
    // Calculate total expenses
    final totalExpenses = expenseCategories.fold(0.0, (sum, category) => sum + category['amount']);
    
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
                  'Total Expenses',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${totalExpenses.toStringAsFixed(2)}',
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
          
          // Expense categories and chart
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Expense categories
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
                        'Expense Categories',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...expenseCategories.map((category) => _buildExpenseCategoryItem(
                        category['category'],
                        category['amount'],
                        category['percentage'],
                        category['trend'],
                        category['color'],
                        textColor,
                      )).toList(),
                    ],
                  ),
                ),
              ),
              
              // Expense chart
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
                          'Expense Distribution',
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
                              sections: expenseCategories.map((category) {
                                return PieChartSectionData(
                                  color: category['color'],
                                  value: category['percentage'].toDouble(),
                                  title: '${category['percentage']}%',
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
                          children: expenseCategories.map((category) => _buildLegendItem(
                            category['category'],
                            category['color'],
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
          
          // Recent expenses
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
                      'Recent Expenses',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Add new expense
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Expense'),
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
                    rows: recentExpenses.map((expense) => _buildExpenseRow(
                      expense['id'],
                      DateFormat('dd MMM yyyy').format(expense['date']),
                      expense['description'],
                      expense['category'],
                      expense['amount'],
                      expense['status'],
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

  Widget _buildExpenseCategoryItem(
    String category,
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
        trendColor = Colors.red;
        break;
      case 'down':
        trendIcon = Icons.arrow_downward;
        trendColor = Colors.green;
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
                  category,
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

  DataRow _buildExpenseRow(
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
              color: Colors.red,
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