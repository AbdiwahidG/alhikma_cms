import 'package:flutter/material.dart';
import '../components/material_stats_card.dart';
import '../components/material_expense_chart.dart';
import '../components/circular_progress_widget.dart';
import '../components/material_data_table.dart';
import '../../../utils/responsive_helper.dart';
import 'package:intl/intl.dart';

class MaterialOverviewTab extends StatelessWidget {
  const MaterialOverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats cards
          GridView.count(
            crossAxisCount: isMobile ? 1 : isTablet ? 2 : 4,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: isMobile ? 2 : 1.5,
            children: [
              const MaterialStatsCard(
                title: 'Total Budget',
                value: 'KES 200,000,000',
                subtitle: '94% of total budget',
                icon: Icons.account_balance_wallet,
                iconColor: Colors.blue,
                showProgress: true,
                progressValue: 0.94,
                progressColor: Colors.blue,
              ),
              const MaterialStatsCard(
                title: 'Total Spent',
                value: 'KES 188,465,315',
                subtitle: '85% of total budget',
                icon: Icons.shopping_cart,
                iconColor: Colors.green,
                showProgress: true,
                progressValue: 0.85,
                progressColor: Colors.green,
              ),
              const MaterialStatsCard(
                title: 'Outstanding Payment',
                value: 'KES 9,431,940',
                subtitle: 'Requires attention',
                icon: Icons.warning,
                iconColor: Colors.orange,
                warningText: 'Payment overdue',
              ),
              const MaterialStatsCard(
                title: 'Project Progress',
                value: '78%',
                subtitle: '45 days to deadline',
                icon: Icons.timeline,
                iconColor: Colors.purple,
                showProgress: true,
                progressValue: 0.78,
                progressColor: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Charts row
          if (isMobile)
            const Column(
              children: [
                MaterialExpenseChart(
                  revenueData: [800, 750, 900, 850, 1000, 950],
                  salesData: [600, 650, 700, 600, 750, 800],
                  months: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                ),
                SizedBox(height: 24),
                CircularProgressWidget(
                  title: 'Materials Budget',
                  percentage: 75.55,
                  totalBudget: 20000000,
                  usedBudget: 15000000,
                  remainingBudget: 5000000,
                  progressColor: Colors.orange,
                  changePercentage: '+10%',
                ),
              ],
            )
          else
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: MaterialExpenseChart(
                    revenueData: [800, 750, 900, 850, 1000, 950],
                    salesData: [600, 650, 700, 600, 750, 800],
                    months: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                  ),
                ),
                SizedBox(width: 24),
                Expanded(
                  child: CircularProgressWidget(
                    title: 'Materials Budget',
                    percentage: 75.55,
                    totalBudget: 20000000,
                    usedBudget: 15000000,
                    remainingBudget: 5000000,
                    progressColor: Colors.orange,
                    changePercentage: '+10%',
                  ),
                ),
              ],
            ),
          const SizedBox(height: 24),

          // Tables
          if (isMobile)
            Column(
              children: [
                MaterialDataTable(
                  columns: const [
                    DataColumn(label: Text('VENDOR')),
                    DataColumn(label: Text('AMOUNT PAID')),
                    DataColumn(label: Text('AMOUNT REMAINING')),
                    DataColumn(label: Text('LAST DELIVERY')),
                  ],
                  rows: _buildOutstandingPayablesRows(isDarkMode),
                ),
                const SizedBox(height: 24),
                MaterialDataTable(
                  columns: const [
                    DataColumn(label: Text('NAME')),
                    DataColumn(label: Text('PHONE NUMBER')),
                    DataColumn(label: Text('AMOUNT PAID')),
                    DataColumn(label: Text('AMOUNT REMAINING')),
                    DataColumn(label: Text('PROGRESS')),
                  ],
                  rows: _buildSuppliersRows(isDarkMode),
                ),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: MaterialDataTable(
                    columns: const [
                      DataColumn(label: Text('VENDOR')),
                      DataColumn(label: Text('AMOUNT PAID')),
                      DataColumn(label: Text('AMOUNT REMAINING')),
                      DataColumn(label: Text('LAST DELIVERY')),
                    ],
                    rows: _buildOutstandingPayablesRows(isDarkMode),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: MaterialDataTable(
                    columns: const [
                      DataColumn(label: Text('NAME')),
                      DataColumn(label: Text('PHONE NUMBER')),
                      DataColumn(label: Text('AMOUNT PAID')),
                      DataColumn(label: Text('AMOUNT REMAINING')),
                      DataColumn(label: Text('PROGRESS')),
                    ],
                    rows: _buildSuppliersRows(isDarkMode),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  List<DataRow> _buildOutstandingPayablesRows(bool isDarkMode) {
    
    return [
      _buildOutstandingPayableRow(
        'ABC Suppliers Ltd',
        2500000,
        500000,
        '2024-03-15',
        isDarkMode,
      ),
      _buildOutstandingPayableRow(
        'XYZ Materials',
        1800000,
        300000,
        '2024-03-10',
        isDarkMode,
      ),
      _buildOutstandingPayableRow(
        'Quality Construction',
        3200000,
        800000,
        '2024-03-05',
        isDarkMode,
      ),
    ];
  }

  DataRow _buildOutstandingPayableRow(
    String vendor,
    double amountPaid,
    double amountRemaining,
    String lastDelivery,
    bool isDarkMode,
  ) {
    final formatter = NumberFormat.currency(symbol: 'KES ');
    
    return DataRow(
      cells: [
        DataCell(Text(vendor)),
        DataCell(Text(formatter.format(amountPaid))),
        DataCell(Text(
          formatter.format(amountRemaining),
          style: TextStyle(
            color: Colors.orange[400],
            fontWeight: FontWeight.bold,
          ),
        )),
        DataCell(Text(lastDelivery)),
      ],
    );
  }

  List<DataRow> _buildSuppliersRows(bool isDarkMode) {
    return [
      _buildSupplierRow(
        'ABC Suppliers Ltd',
        '+254 712 345 678',
        2500000,
        500000,
        0.85,
        isDarkMode,
      ),
      _buildSupplierRow(
        'XYZ Materials',
        '+254 723 456 789',
        1800000,
        300000,
        0.92,
        isDarkMode,
      ),
      _buildSupplierRow(
        'Quality Construction',
        '+254 734 567 890',
        3200000,
        800000,
        0.75,
        isDarkMode,
      ),
    ];
  }

  DataRow _buildSupplierRow(
    String name,
    String phone,
    double amountPaid,
    double amountRemaining,
    double progress,
    bool isDarkMode,
  ) {
    final formatter = NumberFormat.currency(symbol: 'KES ');
    
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(phone)),
        DataCell(Text(formatter.format(amountPaid))),
        DataCell(Text(formatter.format(amountRemaining))),
        DataCell(
          SizedBox(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: isDarkMode ? Colors.grey[800] : Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress > 0.9
                        ? Colors.green
                        : progress > 0.6
                            ? Colors.orange
                            : Colors.red,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
} 