// import 'package:flutter/material.dart';
// import '../../../theme/app_theme.dart';
// import '../../../models/worker.dart';
// import '../../../widgets/labor/labors_list.dart';
// import 'package:provider/provider.dart';
// import '../../../services/worker_service.dart';

// class ProfessionalTab extends StatelessWidget {
//   const ProfessionalTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final workerService = Provider.of<WorkerService>(context);
//     final professionals = workerService.workers
//         .where((w) => w.type == WorkerType.professional)
//         .toList();

//     return Padding(
//       padding: const EdgeInsets.all(24.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           // Title and description
//           Text(
//             'Professional Workers',
//             style: Theme.of(context).textTheme.headlineSmall,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Manage professional workers, contractors, and consultants',
//             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//               color: Colors.grey[600],
//             ),
//           ),
//           const SizedBox(height: 24),
          
//           // Summary cards
//           SizedBox(
//             height: 120,
//             child: Row(
//               children: [
//                 _buildSummaryCard(
//                   context: context,
//                   title: 'Total Professionals',
//                   value: professionals.length.toString(),
//                   icon: Icons.people,
//                   color: Colors.blue,
//                 ),
//                 const SizedBox(width: 16),
//                 _buildSummaryCard(
//                   context: context,
//                   title: 'Average Rate',
//                   value: '\$${_calculateAverageRate(professionals).toStringAsFixed(2)}/hr',
//                   icon: Icons.attach_money,
//                   color: Colors.green,
//                 ),
//                 const SizedBox(width: 16),
//                 _buildSummaryCard(
//                   context: context,
//                   title: 'Project Hours',
//                   value: '${_calculateTotalHours(professionals)} hrs',
//                   icon: Icons.access_time,
//                   color: Colors.orange,
//                 ),
//                 const SizedBox(width: 16),
//                 _buildSummaryCard(
//                   context: context,
//                   title: 'Monthly Cost',
//                   value: '\$${_calculateMonthlyCost(professionals).toStringAsFixed(2)}',
//                   icon: Icons.account_balance_wallet,
//                   color: Colors.purple,
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 24),
          
//           // Professionals list in tabular format
//           Expanded(
//             child: LaborsList(
//               workers: professionals,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
  
//   Widget _buildSummaryCard({
//     required BuildContext context,
//     required String title,
//     required String value,
//     required IconData icon,
//     required Color color,
//   }) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
//     return Expanded(
//       child: Container(
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: isDarkMode ? Colors.grey[800] : Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           border: Border.all(
//             color: isDarkMode ? Colors.grey[700]! : Colors.grey[200]!,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Icon(icon, color: color, size: 20),
//                 const SizedBox(width: 8),
//                 Text(
//                   title,
//                   style: TextStyle(
//                     color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             ),
//             const Spacer(),
//             Text(
//               value,
//               style: TextStyle(
//                 color: isDarkMode ? Colors.white : Colors.black87,
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
  
//   double _calculateAverageRate(List<Worker> professionals) {
//     if (professionals.isEmpty) return 0;
//     final totalRate = professionals.fold<double>(
//       0,
//       (sum, worker) => sum + worker.rate,
//     );
//     return totalRate / professionals.length;
//   }
  
//   int _calculateTotalHours(List<Worker> professionals) {
//     return professionals.fold<int>(
//       0,
//      // (sum, worker) => sum + (worker.hoursPerWeek ?? 0),
//     );
//   }
  
//   double _calculateMonthlyCost(List<Worker> professionals) {
//     return professionals.fold<double>(
//       0,
//       (sum, worker) => sum + ((worker.rate * (worker.hoursPerWeek ?? 0)) * 4),
//     );
//   }
// } 