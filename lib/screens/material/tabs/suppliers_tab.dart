import 'package:flutter/material.dart';
import '../components/material_data_table.dart';
import '../components/material_stats_card.dart';
import '../../../utils/responsive_helper.dart';
import 'package:intl/intl.dart';

class SuppliersTab extends StatelessWidget {
  const SuppliersTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
              MaterialStatsCard(
                title: 'Total Suppliers',
                value: '15',
                subtitle: '3 new this month',
                icon: Icons.people,
                iconColor: Colors.blue,
              ),
              MaterialStatsCard(
                title: 'Active Orders',
                value: '8',
                subtitle: '5 pending delivery',
                icon: Icons.local_shipping,
                iconColor: Colors.green,
              ),
              MaterialStatsCard(
                title: 'Total Payable',
                value: 'KES 9,431,940',
                subtitle: 'To 5 suppliers',
                icon: Icons.account_balance_wallet,
                iconColor: Colors.orange,
                warningText: 'Some payments overdue',
              ),
              MaterialStatsCard(
                title: 'Average Lead Time',
                value: '3.5 Days',
                subtitle: 'Last 30 days',
                icon: Icons.timer,
                iconColor: Colors.purple,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Header section with search and filters
          if (isMobile)
            Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search suppliers...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.filter_list, size: 20),
                    label: const Text('Filters'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add, size: 20),
                    label: const Text('Add Supplier'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    ),
                  ),
                ),
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search suppliers...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: isDarkMode ? Colors.grey[700]! : Colors.grey[300]!,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list, size: 20),
                  label: const Text('Filters'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text('Add Supplier'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                ),
              ],
            ),
          const SizedBox(height: 24),

          // Suppliers table
          Expanded(
            child: MaterialDataTable(
              columns: const [
                DataColumn(label: Text('NAME')),
                DataColumn(label: Text('CONTACT PERSON')),
                DataColumn(label: Text('PHONE')),
                DataColumn(label: Text('EMAIL')),
                DataColumn(label: Text('MATERIALS')),
                DataColumn(label: Text('TOTAL ORDERS')),
                DataColumn(label: Text('AMOUNT PAID')),
                DataColumn(label: Text('AMOUNT DUE')),
                DataColumn(label: Text('STATUS')),
              ],
              rows: _buildSupplierRows(isDarkMode),
              totalItems: 15,
              currentPage: 1,
              itemsPerPage: 10,
              onPageChanged: (page) {},
            ),
          ),
        ],
      ),
    );
  }

  List<DataRow> _buildSupplierRows(bool isDarkMode) {
    return [
      _buildSupplierRow(
        'ABC Suppliers Ltd',
        'John Smith',
        '+254 712 345 678',
        'john@abcsuppliers.com',
        ['Cement', 'Steel', 'Sand'],
        25,
        2500000.0,
        500000.0,
        'Active',
        isDarkMode,
      ),
      _buildSupplierRow(
        'XYZ Materials',
        'Sarah Johnson',
        '+254 723 456 789',
        'sarah@xyzmaterials.com',
        ['Steel', 'Timber'],
        18,
        1800000.0,
        300000.0,
        'Active',
        isDarkMode,
      ),
      _buildSupplierRow(
        'Quality Construction',
        'Mike Wilson',
        '+254 734 567 890',
        'mike@qualityconst.com',
        ['Sand', 'Aggregate'],
        15,
        3200000.0,
        800000.0,
        'On Hold',
        isDarkMode,
      ),
    ];
  }

  DataRow _buildSupplierRow(
    String name,
    String contactPerson,
    String phone,
    String email,
    List<String> materials,
    int totalOrders,
    double amountPaid,
    double amountDue,
    String status,
    bool isDarkMode,
  ) {
    final formatter = NumberFormat.currency(symbol: 'KES ');
    
    Color statusColor;
    if (status == 'Active') {
      statusColor = Colors.green[400]!;
    } else if (status == 'On Hold') {
      statusColor = Colors.orange[400]!;
    } else {
      statusColor = Colors.grey[400]!;
    }
    
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(contactPerson)),
        DataCell(Text(phone)),
        DataCell(Text(email)),
        DataCell(
          Wrap(
            spacing: 4,
            children: materials.map((material) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  material,
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 12,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        DataCell(Text(totalOrders.toString())),
        DataCell(Text(formatter.format(amountPaid))),
        DataCell(
          Text(
            formatter.format(amountDue),
            style: TextStyle(
              color: amountDue > 0 ? Colors.orange[400] : Colors.green[400],
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