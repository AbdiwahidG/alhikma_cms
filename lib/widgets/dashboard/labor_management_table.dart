import 'package:flutter/material.dart';

class LaborManagementTable extends StatelessWidget {
  const LaborManagementTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Labor Management',
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
                columns: [
                  DataColumn(label: Text('Worker')),
                  DataColumn(label: Text('Role')),
                  DataColumn(label: Text('Hours')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Last Active')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: [
                  _buildDataRow(
                    context,
                    name: 'John Smith',
                    role: 'Carpenter',
                    hours: '160',
                    status: 'Active',
                    lastActive: 'Today',
                  ),
                  _buildDataRow(
                    context,
                    name: 'Mike Johnson',
                    role: 'Electrician',
                    hours: '145',
                    status: 'Active',
                    lastActive: 'Today',
                  ),
                  _buildDataRow(
                    context,
                    name: 'Sarah Williams',
                    role: 'Plumber',
                    hours: '120',
                    status: 'On Leave',
                    lastActive: 'Mar 18, 2024',
                  ),
                  _buildDataRow(
                    context,
                    name: 'David Brown',
                    role: 'Mason',
                    hours: '180',
                    status: 'Active',
                    lastActive: 'Today',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(
    BuildContext context, {
    required String name,
    required String role,
    required String hours,
    required String status,
    required String lastActive,
  }) {
    return DataRow(
      cells: [
        DataCell(
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  name.split(' ').map((e) => e[0]).join(''),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(name),
            ],
          ),
        ),
        DataCell(Text(role)),
        DataCell(Text(hours)),
        DataCell(
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _getStatusColor(status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: _getStatusColor(status),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DataCell(Text(lastActive)),
        DataCell(
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {},
                color: Theme.of(context).colorScheme.primary,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {},
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Active':
        return Colors.green;
      case 'On Leave':
        return Colors.orange;
      case 'Inactive':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
} 