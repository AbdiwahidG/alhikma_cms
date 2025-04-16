import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../models/worker.dart';
import 'package:intl/intl.dart';

class LaborsList extends StatelessWidget {
  final List<Worker> workers;
  final bool showActions;
  
  const LaborsList({
    super.key,
    required this.workers,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header section with count and actions
        Padding(
          padding: const EdgeInsets.fromLTRB(4, 0, 4, 16),
          child: Row(
            children: [
              Text(
                '${workers.length} Total workers',
                style: TextStyle(
                  fontSize: 15,
                  color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                ),
              ),
              const Spacer(),
              if (showActions) ...[
                // Search field
                SizedBox(
                  width: 240,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search workers...',
                      prefixIcon: const Icon(Icons.search, size: 20),
                      contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                // Filter button
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list, size: 20),
                  label: const Text('Filters'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                const SizedBox(width: 16),
                // Add worker button
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add, size: 20),
                  label: const Text('Add Worker'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.darkTheme.primaryColor,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ],
          ),
        ),
        
        // Workers table
        Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isDarkMode ? Colors.grey[800]! : Colors.grey[200]!,
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(
                isDarkMode ? Colors.grey[900] : Colors.grey[50],
              ),
              columns: const [
                DataColumn(label: Text('WORKER NAME')),
                DataColumn(label: Text('POSITION')),
                DataColumn(label: Text('TYPE')),
                DataColumn(label: Text('RATE')),
                DataColumn(label: Text('PAYMENT')),
                DataColumn(label: Text('START DATE')),
                DataColumn(label: Text('STATUS')),
              ],
              rows: workers.map((worker) {
                final startDate = DateFormat('MMM dd, yyyy').format(worker.startDate);
                
                return DataRow(
                  cells: [
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: _getAvatarColor(worker.name),
                            child: Text(
                              worker.name.substring(0, 2).toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(worker.name),
                        ],
                      ),
                    ),
                    DataCell(Text(worker.position)),
                    DataCell(Text(_formatWorkerType(worker.type))),
                    DataCell(Text(_formatRate(worker.rate))),
                    DataCell(Text(_formatPaymentFrequency(worker.paymentFrequency))),
                    DataCell(Text(startDate)),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: worker.isActive ? Colors.green[100] : Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          worker.isActive ? 'Active' : 'Inactive',
                          style: TextStyle(
                            color: worker.isActive ? Colors.green[700] : Colors.grey[700],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
  
  String _formatWorkerType(WorkerType type) {
    switch (type) {
      case WorkerType.weeklyWage:
        return 'Weekly Wage';
      case WorkerType.professional:
        return 'Professional';
      case WorkerType.salaried:
        return 'Salaried';
      case WorkerType.miscellaneous:
        return 'Miscellaneous';
    }
  }

  String _formatPaymentFrequency(PaymentFrequency frequency) {
    switch (frequency) {
      case PaymentFrequency.weekly:
        return 'Weekly';
      case PaymentFrequency.monthly:
        return 'Monthly';
      case PaymentFrequency.oneTime:
        return 'One Time';
    }
  }

  String _formatRate(double rate) {
    final formatter = NumberFormat.currency(symbol: '\$');
    return formatter.format(rate);
  }
  
  Color _getAvatarColor(String name) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
    ];
    
    final index = name.hashCode % colors.length;
    return colors[index];
  }
} 