import 'package:flutter/material.dart';
import '../components/material_data_table.dart';
import '../../../utils/responsive_helper.dart';
import 'package:intl/intl.dart';

class MaterialManagementTab extends StatelessWidget {
  const MaterialManagementTab({super.key});

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
                    hintText: 'Search materials...',
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
                      hintText: 'Search materials...',
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

          // Materials table
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
              ],
              rows: _buildMaterialRows(isDarkMode),
              totalItems: 100,
              currentPage: 1,
              itemsPerPage: 10,
              onPageChanged: (page) {},
            ),
          ),
        ],
      ),
    );
  }

  List<DataRow> _buildMaterialRows(bool isDarkMode) {
    final formatter = NumberFormat.currency(symbol: 'KES ');
    
    return [
      _buildMaterialRow(
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
        isDarkMode,
      ),
      _buildMaterialRow(
        'MAT002',
        'Steel Reinforcement Bars - 12mm',
        'XYZ Materials',
        '2024-03-10',
        'Tons',
        10,
        95000.0,
        950000.0,
        950000.0,
        0.0,
        isDarkMode,
      ),
      _buildMaterialRow(
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
        isDarkMode,
      ),
    ];
  }

  DataRow _buildMaterialRow(
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
    bool isDarkMode,
  ) {
    final formatter = NumberFormat.currency(symbol: 'KES ');
    final numberFormatter = NumberFormat('#,##0');
    
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
              color: balance > 0 ? Colors.orange[400] : Colors.green[400],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
} 