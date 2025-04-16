import 'package:flutter/material.dart';
import 'package:alhikma_cms/config/theme.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';
import 'package:alhikma_cms/widgets/labor/labor_expenses_chart.dart';
import 'package:alhikma_cms/widgets/labor/labor_budget_indicator.dart';
import 'package:alhikma_cms/widgets/labor/weekly_labor_cost_table.dart';
import 'package:alhikma_cms/widgets/labor/labors_list.dart';

class OverviewTab extends StatelessWidget {
  const OverviewTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Metrics Cards
          GridView.count(
            crossAxisCount: isMobile ? 1 : 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: isMobile ? 2.5 : 1.8,
            children: [
              _buildMetricCard(
                context,
                'Total Budget',
                '200,000,000',
                'KES',
                Colors.blue,
                isLightTheme,
              ),
              _buildMetricCard(
                context,
                'Total Spent',
                '188,465,315',
                '94%',
                Colors.green,
                isLightTheme,
              ),
              _buildMetricCard(
                context,
                'Outstanding Payment',
                '9,431,940',
                'Requires attention',
                Colors.orange,
                isLightTheme,
              ),
              _buildMetricCard(
                context,
                'Project Progress',
                '78%',
                '45 days to deadline',
                Colors.purple,
                isLightTheme,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Labor Expenses and Budget Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Labor Expenses',
                            style: TextStyle(
                              color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const SizedBox(
                        height: 300,
                        child: LaborExpensesChart(),
                      ),
                    ],
                  ),
                ),
              ),
              if (!isMobile) const SizedBox(width: 16),
              if (!isMobile)
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Labour budget',
                              style: TextStyle(
                                color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const SizedBox(
                          height: 300,
                          child: LaborBudgetIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),

          // Weekly Labor Cost Table
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Weekly Labor Cost',
                      style: TextStyle(
                        color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('View All'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const WeeklyLaborCostTable(),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Labors List
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Labours',
                      style: TextStyle(
                        color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                      ),
                      child: const Text('Add New Worker'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const LaborsList(workers: [],),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard(BuildContext context, String title, String value,
      String subtitle, Color color, bool isLightTheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 