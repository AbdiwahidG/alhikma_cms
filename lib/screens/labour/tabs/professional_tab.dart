import 'package:flutter/material.dart';
import 'package:alhikma_cms/config/theme.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';
import 'package:fl_chart/fl_chart.dart';

class ProfessionalTab extends StatelessWidget {
  const ProfessionalTab({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Professional Summary Cards
          GridView.count(
            crossAxisCount: isMobile ? 2 : 4,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: isMobile ? 1.5 : 1.8,
            children: [
              _buildSummaryCard(
                'Total Professionals',
                '24',
                'active contracts',
                Icons.people,
                AppTheme.primaryColor,
                isLightTheme,
                textColor,
              ),
              _buildSummaryCard(
                'Average Rate',
                '\$85',
                'per hour',
                Icons.attach_money,
                AppTheme.secondaryColor,
                isLightTheme,
                textColor,
              ),
              _buildSummaryCard(
                'Project Hours',
                '960',
                'this month',
                Icons.access_time,
                AppTheme.warningColor,
                isLightTheme,
                textColor,
              ),
              _buildSummaryCard(
                'Total Cost',
                '\$81,600',
                'this month',
                Icons.payments,
                AppTheme.successColor,
                isLightTheme,
                textColor,
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Professional Distribution Chart
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
                Text(
                  'Professional Distribution',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 300,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 70,
                      sections: [
                        PieChartSectionData(
                          value: 35,
                          title: '35%\nEngineers',
                          color: AppTheme.primaryColor,
                          radius: 100,
                          titleStyle: TextStyle(
                            color: isLightTheme ? Colors.white : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        PieChartSectionData(
                          value: 25,
                          title: '25%\nArchitects',
                          color: AppTheme.secondaryColor,
                          radius: 100,
                          titleStyle: TextStyle(
                            color: isLightTheme ? Colors.white : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        PieChartSectionData(
                          value: 20,
                          title: '20%\nConsultants',
                          color: AppTheme.warningColor,
                          radius: 100,
                          titleStyle: TextStyle(
                            color: isLightTheme ? Colors.white : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        PieChartSectionData(
                          value: 20,
                          title: '20%\nOthers',
                          color: AppTheme.infoColor,
                          radius: 100,
                          titleStyle: TextStyle(
                            color: isLightTheme ? Colors.white : Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Professional List
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
                      'Professional List',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('Add Professional'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    headingRowColor: MaterialStateProperty.all(
                      isLightTheme ? Colors.grey[100] : const Color(0xFF252525),
                    ),
                    columns: [
                      'Name',
                      'Role',
                      'Specialization',
                      'Rate/Hour',
                      'Hours/Week',
                      'Start Date',
                      'Status',
                    ].map((header) => DataColumn(
                      label: Text(
                        header,
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )).toList(),
                    rows: [
                      _buildProfessionalRow(
                        'Dr. Sarah Johnson',
                        'Structural Engineer',
                        'Steel Structures',
                        95,
                        40,
                        '01 Jan 2023',
                        'Active',
                        textColor,
                      ),
                      _buildProfessionalRow(
                        'Michael Chen',
                        'Architect',
                        'Green Buildings',
                        85,
                        35,
                        '15 Feb 2023',
                        'Active',
                        textColor,
                      ),
                      _buildProfessionalRow(
                        'Emma Williams',
                        'Consultant',
                        'Project Management',
                        90,
                        30,
                        '01 Mar 2023',
                        'On Leave',
                        textColor,
                      ),
                      _buildProfessionalRow(
                        'James Wilson',
                        'MEP Engineer',
                        'HVAC Systems',
                        88,
                        40,
                        '15 Mar 2023',
                        'Active',
                        textColor,
                      ),
                      _buildProfessionalRow(
                        'Lisa Anderson',
                        'Interior Designer',
                        'Commercial Spaces',
                        75,
                        25,
                        '01 Apr 2023',
                        'Contract',
                        textColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, String subtitle,
      IconData icon, Color color, bool isLightTheme, Color textColor) {
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
          Row(
            children: [
              Icon(icon, color: color, size: 24),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: textColor,
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
            ),
          ),
        ],
      ),
    );
  }

  DataRow _buildProfessionalRow(
    String name,
    String role,
    String specialization,
    double rate,
    int hours,
    String startDate,
    String status,
    Color textColor,
  ) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'active':
        statusColor = AppTheme.successColor;
        break;
      case 'on leave':
        statusColor = AppTheme.warningColor;
        break;
      case 'contract':
        statusColor = AppTheme.infoColor;
        break;
      default:
        statusColor = Colors.grey;
    }

    return DataRow(
      cells: [
        DataCell(Text(name, style: TextStyle(color: textColor))),
        DataCell(Text(role, style: TextStyle(color: textColor))),
        DataCell(Text(specialization, style: TextStyle(color: textColor))),
        DataCell(Text('\$$rate', style: TextStyle(color: textColor))),
        DataCell(Text('$hours', style: TextStyle(color: textColor))),
        DataCell(Text(startDate, style: TextStyle(color: textColor))),
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