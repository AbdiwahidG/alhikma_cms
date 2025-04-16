import 'package:alhikma_cms/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alhikma_cms/models/task.dart';


class TimelineListView extends StatefulWidget {
  const TimelineListView({super.key});

  @override
  _TimelineListViewState createState() => _TimelineListViewState();
}

class _TimelineListViewState extends State<TimelineListView> {
  final List<Task> _tasks = [
    Task(
      id: '1',
      name: 'Foundation Walls',
      category: 'Foundation',
      startDate: DateTime(2025, 3, 3),
      endDate: DateTime(2025, 3, 7),
      status: 'In Progress',
      assignedTo: 'JD',
      categoryColor: Colors.green,
    ),
    Task(
      id: '2',
      name: 'Site Inspection',
      category: 'Site Prep',
      startDate: DateTime(2025, 3, 3),
      endDate: DateTime(2025, 3, 3),
      status: 'In Progress',
      assignedTo: 'MR',
      categoryColor: Colors.blue,
      isMilestone: true,
    ),
    Task(
      id: '3',
      name: 'Waterproofing',
      category: 'Foundation',
      startDate: DateTime(2025, 3, 10),
      endDate: DateTime(2025, 3, 12),
      status: 'Scheduled',
      assignedTo: 'JD',
      categoryColor: Colors.green,
    ),
    Task(
      id: '4',
      name: 'Foundation Complete',
      category: 'Milestone',
      startDate: DateTime(2025, 3, 15),
      endDate: DateTime(2025, 3, 15),
      status: 'Scheduled',
      assignedTo: 'All',
      categoryColor: Colors.amber,
      isMilestone: true,
    ),
    Task(
      id: '5',
      name: 'Column Installation',
      category: 'Steel Frame',
      startDate: DateTime(2025, 3, 17),
      endDate: DateTime(2025, 3, 21),
      status: 'Scheduled',
      assignedTo: 'KL',
      categoryColor: Colors.orange,
    ),
    Task(
      id: '6',
      name: 'Beam Installation',
      category: 'Steel Frame',
      startDate: DateTime(2025, 3, 24),
      endDate: DateTime(2025, 3, 31),
      status: 'Scheduled',
      assignedTo: 'KL',
      categoryColor: Colors.orange,
    ),
    Task(
      id: '7',
      name: 'Electrical Rough-In',
      category: 'Electrical',
      startDate: DateTime(2025, 4, 3),
      endDate: DateTime(2025, 4, 14),
      status: 'Scheduled',
      assignedTo: 'RH',
      categoryColor: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Use actual theme from context instead of hardcoded value
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    //final backgroundColor = isLightTheme ? AppTheme.lightBackground : AppTheme.darkBackground;
    final surfaceColor = isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    final headerColor = isLightTheme ? Colors.grey[100] : const Color(0xFF252525);
   // final dividerColor = isLightTheme ? Colors.grey[300] : const Color(0xFF2A2A2A);
    
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isLightTheme
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Task',
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Category',
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Start Date',
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'End Date',
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Status',
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    'Assigned',
                    style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return Container(
                  decoration: BoxDecoration(
                    color: index.isEven && isLightTheme ? Colors.grey[50] : surfaceColor,
                    border: Border(
                      bottom: BorderSide(color: Colors.blueGrey, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              if (task.isMilestone)
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.flag,
                                    color: AppTheme.primaryColor,
                                    size: 20,
                                  ),
                                ),
                              Expanded(
                                child: Text(
                                  task.name,
                                  style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: task.categoryColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Foundation',
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          DateFormat('MMM d, yyyy').format(task.startDate),
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          DateFormat('MMM d, yyyy').format(task.endDate),
                          style: TextStyle(color: textColor),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getStatusColor(task.status),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            task.status,
                            style: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: isLightTheme ? Colors.grey[300] : Colors.grey[700],
                          radius: 16,
                          child: Text(
                            task.assignedTo,
                            style: TextStyle(
                              color: isLightTheme ? Colors.black87 : Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: isLightTheme ? Colors.grey[50] : surfaceColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              border: Border(
                top: BorderSide(color: Colors.blueGrey, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Showing ${_tasks.length} of 23 tasks',
                  style: TextStyle(color: isLightTheme ? Colors.black54 : Colors.white70),
                ),
                Row(
                  children: [
                    _buildPageButton('1', isSelected: true, isLightTheme: isLightTheme),
                    _buildPageButton('2', isLightTheme: isLightTheme),
                    _buildPageButton('3', isLightTheme: isLightTheme),
                    _buildPageButton('4', isLightTheme: isLightTheme),
                    _buildPageButton('Next →', isLightTheme: isLightTheme),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageButton(String label, {bool isSelected = false, required bool isLightTheme}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isSelected
            ? AppTheme.primaryColor
            : isLightTheme
                ? Colors.grey[200]
                : const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : isLightTheme
                    ? Colors.black87
                    : Colors.white,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'in progress':
        return AppTheme.warningColor;
      case 'scheduled':
        return AppTheme.infoColor;
      case 'completed':
        return AppTheme.successColor;
      case 'unfinished':
        return AppTheme.errorColor;
      default:
        return Colors.grey;
    }
  }
}