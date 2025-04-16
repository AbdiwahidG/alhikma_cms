import 'package:flutter/material.dart';

class MaterialManagementTable extends StatelessWidget {
  const MaterialManagementTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if we're on a small screen
        final isSmallScreen = constraints.maxWidth < 600;
        
        return Card(
          child: Padding(
             padding: const EdgeInsets.all(16.0),
            // padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Material Management',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.view_agenda_rounded),
                  label: const Text('View All'),
                ),
                  ],
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    // columnSpacing: isSmallScreen ? 16.0 : 24.0,
                    // dataRowHeight: isSmallScreen ? 48.0 : 56.0,
                    // headingRowHeight: isSmallScreen ? 48.0 : 56.0,
                    columns: [
                      DataColumn(
                        label: Text(
                          'Material',
                          style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Quantity',
                          style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Unit',
                          style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Status',
                          style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Actions',
                          style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
                        ),
                      ),
                    ],
                    rows: [
                      _buildDataRow(
                        context,
                        material: 'Cement',
                        quantity: '500',
                        unit: 'Bags',
                        status: 'In Stock',
                        isSmallScreen: isSmallScreen,
                      ),
                      _buildDataRow(
                        context,
                        material: 'Steel Bars',
                        quantity: '200',
                        unit: 'Tons',
                        status: 'Low Stock',
                        isSmallScreen: isSmallScreen,
                      ),
                      _buildDataRow(
                        context,
                        material: 'Bricks',
                        quantity: '10000',
                        unit: 'Pieces',
                        status: 'In Stock',
                        isSmallScreen: isSmallScreen,
                      ),
                      _buildDataRow(
                        context,
                        material: 'Sand',
                        quantity: '300',
                        unit: 'Trucks',
                        status: 'Ordered',
                        isSmallScreen: isSmallScreen,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  DataRow _buildDataRow(
    BuildContext context, {
    required String material,
    required String quantity,
    required String unit,
    required String status,
    required bool isSmallScreen,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            material,
            style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
          ),
        ),
        DataCell(
          Text(
            quantity,
            style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
          ),
        ),
        DataCell(
          Text(
            unit,
            style: TextStyle(fontSize: isSmallScreen ? 12 : 14),
          ),
        ),
        DataCell(
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: isSmallScreen ? 6 : 8,
              vertical: isSmallScreen ? 2 : 4,
            ),
            decoration: BoxDecoration(
              color: _getStatusColor(status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                fontSize: isSmallScreen ? 10 : 12,
                color: _getStatusColor(status),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  size: isSmallScreen ? 18 : 20,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  size: isSmallScreen ? 18 : 20,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'In Stock':
        return Colors.green;
      case 'Low Stock':
        return Colors.orange;
      case 'Ordered':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
} 