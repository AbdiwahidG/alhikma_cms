import 'package:flutter/material.dart';
import '../components/material_data_table.dart';
import '../../../utils/responsive_helper.dart';
import 'package:intl/intl.dart';

class UnpaidMaterialsTab extends StatelessWidget {
  const UnpaidMaterialsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isMobile = ResponsiveHelper.isMobile(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header section with search and filters
          if (isMobile)
            Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search unpaid materials...',
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
              ],
            )
          else
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search unpaid materials...',
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
              ],
            ),
          const SizedBox(height: 24),

          // Warning card for total unpaid amount
          Card(
            color: Colors.orange[100],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.orange[800]),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Unpaid Amount',
                          style: TextStyle(
                            color: Colors.orange[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'KES 75,000 pending payment across 3 materials',
                          style: TextStyle(
                            color: Colors.orange[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Unpaid materials table
          Expanded(
            child: MaterialDataTable(
              columns: const [
                DataColumn(label: Text('ITEM NO.')),
                DataColumn(label: Text('DESCRIPTION')),
                DataColumn(label: Text('SUPPLIER')),
                DataColumn(label: Text('DATE')),
                DataColumn(label: Text('UNITS')),
                DataColumn(label: Text('QUANTITY')),
                DataColumn(label: Text('UNIT PRICE')),
                DataColumn(label: Text('TOTAL')),
                DataColumn(label: Text('PAID')),
                DataColumn(label: Text('BALANCE')),
                DataColumn(label: Text('STATUS')),
              ],
              rows: _buildUnpaidMaterialRows(isDarkMode),
              totalItems: 3,
              currentPage: 1,
              itemsPerPage: 10,
              onPageChanged: (page) {},
            ),
          ),
        ],
      ),
    );
  }

  List<DataRow> _buildUnpaidMaterialRows(bool isDarkMode) {
    return [
      _buildUnpaidMaterialRow(
        'MAT001',
        'Cement - Portland Type I',
        'ABC Suppliers Ltd',
        '2024-03-15',
        'Bags',
        500,
        850.0,
        425000.0,
        400000.0,
        25000.0,
        'Partially Paid',
        isDarkMode,
      ),
      _buildUnpaidMaterialRow(
        'MAT003',
        'Sand - River',
        'Quality Construction',
        '2024-03-05',
        'Cubic M',
        100,
        2500.0,
        250000.0,
        200000.0,
        50000.0,
        'Payment Due',
        isDarkMode,
      ),
    ];
  }

  DataRow _buildUnpaidMaterialRow(
    String itemNo,
    String description,
    String supplier,
    String date,
    String units,
    int quantity,
    double unitPrice,
    double total,
    double paid,
    double balance,
    String status,
    bool isDarkMode,
  ) {
    final formatter = NumberFormat.currency(symbol: 'KES ');
    final numberFormatter = NumberFormat('#,##0');
    
    Color statusColor;
    if (status == 'Partially Paid') {
      statusColor = Colors.orange[400]!;
    } else if (status == 'Payment Due') {
      statusColor = Colors.red[400]!;
    } else {
      statusColor = Colors.grey[400]!;
    }
    
    return DataRow(
      cells: [
        DataCell(Text(itemNo)),
        DataCell(Text(description)),
        DataCell(Text(supplier)),
        DataCell(Text(date)),
        DataCell(Text(units)),
        DataCell(Text(numberFormatter.format(quantity))),
        DataCell(Text(formatter.format(unitPrice))),
        DataCell(Text(formatter.format(total))),
        DataCell(Text(formatter.format(paid))),
        DataCell(
          Text(
            formatter.format(balance),
            style: TextStyle(
              color: Colors.red[400],
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