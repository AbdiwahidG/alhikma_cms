import 'package:alhikma_cms/widgets/dashboard/timeline_widget.dart';
import 'package:flutter/material.dart';
import 'package:alhikma_cms/widgets/common/app_sidebar.dart';
import 'package:alhikma_cms/widgets/dashboard/key_metrics_widget.dart';
import 'package:alhikma_cms/widgets/dashboard/weekly_expense_chart.dart';
import 'package:alhikma_cms/widgets/dashboard/budget_breakdown_chart.dart';
import 'package:alhikma_cms/widgets/dashboard/project_milestone_progress.dart';
import 'package:alhikma_cms/widgets/dashboard/material_management_table.dart';
import 'package:alhikma_cms/widgets/dashboard/labor_management_table.dart';
import 'package:alhikma_cms/widgets/common/page_header.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            children: [
              // Sidebar - Always visible but collapsible
              const AppSidebar(selectedIndex: 0),
              
              // Main content
              Expanded(
                child: Column(
                  children: [
                    // Page header with search and profile
                    const PageHeader(title: 'Dashboard'),
                    
                    // Scrollable main content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const KeyMetricsWidget(),
                            const SizedBox(height: 24),
                            
                            // Charts section - responsive layout
                            _buildChartsSection(constraints),
                            
                            const SizedBox(height: 24),
                            
                            // Tables and milestones section - responsive layout
                            _buildTablesSection(constraints),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  
  Widget _buildChartsSection(BoxConstraints constraints) {
    // Determine if we're on a small screen
    final isSmallScreen = constraints.maxWidth < 1200;
    
    if (isSmallScreen) {
      return const Column(
        children: [
          Card(
            child: SizedBox(
              height: 400,
              child: WeeklyExpenseChart(),
            ),
          ),
          SizedBox(height: 24),
          Card(
            child: SizedBox(
              height: 400,
              child: BudgetBreakdownChart(),
            ),
          ),
        ],
      );
    } else {
      return const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Card(
              child: SizedBox(
                height: 400,
                child: WeeklyExpenseChart(),
              ),
            ),
          ),
          SizedBox(width: 24),
          Expanded(
            flex: 2,
            child: Card(
              child: SizedBox(
                height: 400,
                child: BudgetBreakdownChart(),
              ),
            ),
          ),
        ],
      );
    }
  }
  
  Widget _buildTablesSection(BoxConstraints constraints) {
    // Determine if we're on a small screen
    final isSmallScreen = constraints.maxWidth < 1200;
    
    if (isSmallScreen) {
      return const Column(
        children: [
          ProjectMilestoneProgress(),
          SizedBox(height: 24),
          TimelineWidget(),
          SizedBox(height: 24),
          MaterialManagementTable(),
          SizedBox(height: 24),
          LaborManagementTable(),
        ],
      );
    } else {
      return const Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: 600,
                  child: ProjectMilestoneProgress(),
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 600,
                  child: TimelineWidget(),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 400,
                  child: MaterialManagementTable(),
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 400,
                  child: LaborManagementTable(),
                ),
              ),
            ],
          ),

        ],
      );
    }
  }
}


// crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: ,
//           ),
//           const SizedBox(width: 24),
//           Expanded(
//             flex: 3,
//             child: Column(
//               children: [
//                 MaterialManagementTable(),
//                 const SizedBox(height: 24),
//                 LaborManagementTable(),
//               ],
//             ),
//           ),
//         ],