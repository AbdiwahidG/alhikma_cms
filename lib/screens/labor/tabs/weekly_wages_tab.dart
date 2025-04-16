import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:intl/intl.dart';
import '../../../config/theme.dart';
import '../../../models/worker.dart';
//import '../../../models/payment.dart';
//import '../../../services/worker_service.dart';
import '../../../services/payment_service.dart';
import '../../../widgets/labor/labors_list.dart';
import '../../../services/worker_service.dart';

class WeeklyWagesTab extends StatelessWidget {
  const WeeklyWagesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    
    final workerService = Provider.of<WorkerService>(context);
    final weeklyWorkers = workerService.workers
        .where((w) => w.type == WorkerType.weeklyWage)
        .toList();
    
    // Get week codes - either from service or use sample data
    final paymentService = Provider.of<PaymentService>(context);
    List<String> weekCodes = paymentService.getUniqueWeekCodes();
    if (weekCodes.isEmpty) {
      weekCodes = ['W023', 'W022', 'W021', 'W020', 'W019', 'W018', 'W017', 'W016', 'W015', 'W014'];
    }
    
    // Sample data for positions and their amounts
    final Map<String, List<double>> positionData = {
      'Foreman': [18000, 18000, 18000, 18000, 18000, 18000, 18000, 18000, 18000, 18000],
      'Assistant': [18000, 18000, 18000, 18000, 18000, 18000, 18000, 18000, 18000, 18000],
      'Carpenter': [48000, 48000, 18000, 0, 11000, 11000, 0, 0, 0, 0],
      'Mason': [36000, 36000, 36000, 36000, 11000, 11000, 11000, 11000, 0, 0],
      'Helper': [48000, 11000, 11000, 11000, 18000, 23000, 0, 18000, 18000, 18000],
      'Steel Fixer': [47600, 18000, 18000, 47600, 0, 0, 47600, 0, 47600, 47600],
    };
    
    // Sample dates for week codes
    final Map<String, String> weekDates = {
      'W023': '29 Dec 2022',
      'W022': '24 Dec 2022',
      'W021': '12 Dec 2022',
      'W020': '21 Oct 2022',
      'W019': '21 Oct 2022',
      'W018': '21 Oct 2022',
      'W017': '19 Sep 2022',
      'W016': '19 Sep 2022',
      'W015': '19 Sep 2022',
      'W014': '10 Aug 2022',
    };
    
    // Total for each week
    final totals = [215600, 215600, 215600, 215600, 215600, 215600, 215600, 215600, 215600, 113000];
    
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title and description
          Text(
            'Weekly Wage Workers',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Manage and track weekly wage workers and their payments',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          
          // Workers list in tabular format
          Expanded(
            child: LaborsList(
              workers: weeklyWorkers,
            ),
          ),
        ],
      ),
    );
  }
} 