// import 'package:flutter/material.dart';
// import 'package:alhikma_cms/utils/responsive_helper.dart';
// import 'package:alhikma_cms/widgets/cards/project_card.dart';
// import 'package:alhikma_cms/widgets/cards/timeline_card.dart';
// import 'package:alhikma_cms/widgets/milestones/milestone_card.dart';
// import 'package:alhikma_cms/widgets/cards/labor_card.dart';
// import 'package:alhikma_cms/widgets/cards/material_card.dart';
// import 'package:alhikma_cms/widgets/cards/financial_card.dart';

// class ProjectDetailsScreen extends StatelessWidget {
//   const ProjectDetailsScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     final isMobile = ResponsiveHelper.isMobile(context);
//     final isTablet = ResponsiveHelper.isTablet(context);
    
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Project Details'),
//         actions: [
//           if (!isMobile) ...[
//             IconButton(
//               icon: const Icon(Icons.edit),
//               onPressed: () {
//                 // TODO: Implement edit functionality
//               },
//             ),
//             IconButton(
//               icon: const Icon(Icons.delete),
//               onPressed: () {
//                 // TODO: Implement delete functionality
//               },
//             ),
//           ],
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Project Overview Card
//             const ProjectCard(
//               title: 'Project Overview',
//               description: 'Sample project description',
//               startDate: '2024-01-01',
//               endDate: '2024-12-31',
//               status: 'In Progress',
//               progress: 0.5,
//             ),
//             const SizedBox(height: 16),

//             // Timeline and Milestones
//             if (isMobile || isTablet)
//               const Column(
//                 children: [
//                   TimelineCard(
//                     title: 'Project Timeline',
//                     events: [
//                       'Project Started',
//                       'Design Phase',
//                       'Construction Phase',
//                       'Final Inspection',
//                     ],
//                   ),
//                   SizedBox(height: 16),
//                   MilestoneCard(
//                     title: 'Project Milestones',
//                     milestones: [
//                       'Design Approval',
//                       'Foundation Complete',
//                       'Structure Complete',
//                       'Interior Complete',
//                     ],
//                   ),
//                 ],
//               )
//             else
//               const Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: TimelineCard(
//                       title: 'Project Timeline',
//                       events: [
//                         'Project Started',
//                         'Design Phase',
//                         'Construction Phase',
//                         'Final Inspection',
//                       ],
//                     ),
//                   ),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: MilestoneCard(
//                       title: 'Project Milestones',
//                       milestones: [
//                         'Design Approval',
//                         'Foundation Complete',
//                         'Structure Complete',
//                         'Interior Complete',
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             const SizedBox(height: 16),
            
//             // Labor and Materials
//             if (isMobile || isTablet)
//               Column(
//                 children: [
//                   const LaborCard(
//                     title: 'Labor Management',
//                     totalWorkers: 10,
//                     activeWorkers: 8,
//                     totalHours: 160,
//                     averageHours: 8,
//                   ),
//                   const SizedBox(height: 16),
//                   const MaterialCard(
//                     title: 'Material Management',
//                     totalMaterials: 20,
//                     orderedMaterials: 15,
//                     deliveredMaterials: 10,
//                     pendingMaterials: 5,
//                   ),
//                 ],
//               )
//             else
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Expanded(
//                     child: LaborCard(
//                       title: 'Labor Management',
//                       totalWorkers: 10,
//                       activeWorkers: 8,
//                       totalHours: 160,
//                       averageHours: 8,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   const Expanded(
//                     child: MaterialCard(
//                       title: 'Material Management',
//                       totalMaterials: 20,
//                       orderedMaterials: 15,
//                       deliveredMaterials: 10,
//                       pendingMaterials: 5,
//                     ),
//                   ),
//                 ],
//               ),
//             const SizedBox(height: 16),

//             // Financial Overview
//             const FinancialCard(
//               title: 'Financial Overview',
//               totalBudget: 100000,
//               spentAmount: 50000,
//               remainingAmount: 50000,
//               laborCost: 20000,
//               materialCost: 25000,
//               otherCost: 5000,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: isMobile
//           ? FloatingActionButton(
//               onPressed: () {
//                 // TODO: Implement edit functionality
//               },
//               child: const Icon(Icons.edit),
//             )
//           : null,
//     );
//   }
// } 