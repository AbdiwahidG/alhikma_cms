import 'package:flutter/material.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';
import 'package:alhikma_cms/widgets/milestones/milestone_card.dart';

class MilestoneList extends StatelessWidget {
  final String filter;
  final String sortBy;
  final bool showCompleted;

  const MilestoneList({
    super.key,
    required this.filter,
    required this.sortBy,
    required this.showCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    // Mock data for milestones
    final List<Map<String, dynamic>> milestones = [
      {
        'id': '1',
        'title': 'Site Preparation',
        'description': 'Complete site clearing and excavation',
        'dueDate': DateTime.now().add(const Duration(days: 15)),
        'status': 'In Progress',
        'progress': 0.6,
        'priority': 'High',
        'assignedTo': 'John Doe',
      },
      {
        'id': '2',
        'title': 'Foundation Work',
        'description': 'Complete foundation and waterproofing',
        'dueDate': DateTime.now().add(const Duration(days: 30)),
        'status': 'Not Started',
        'progress': 0.0,
        'priority': 'High',
        'assignedTo': 'Jane Smith',
      },
      {
        'id': '3',
        'title': 'Steel Framework',
        'description': 'Install steel columns and beams',
        'dueDate': DateTime.now().add(const Duration(days: 45)),
        'status': 'Not Started',
        'progress': 0.0,
        'priority': 'Medium',
        'assignedTo': 'Mike Johnson',
      },
      {
        'id': '4',
        'title': 'Electrical Work',
        'description': 'Complete electrical rough-in',
        'dueDate': DateTime.now().add(const Duration(days: 60)),
        'status': 'Not Started',
        'progress': 0.0,
        'priority': 'Medium',
        'assignedTo': 'Sarah Williams',
      },
      {
        'id': '5',
        'title': 'Masonry & Finish',
        'description': 'Complete masonry work and finishing',
        'dueDate': DateTime.now().add(const Duration(days: 75)),
        'status': 'Not Started',
        'progress': 0.0,
        'priority': 'Low',
        'assignedTo': 'David Brown',
      },
      {
        'id': '6',
        'title': 'Final Inspection',
        'description': 'Complete final inspection and approval',
        'dueDate': DateTime.now().add(const Duration(days: 90)),
        'status': 'Not Started',
        'progress': 0.0,
        'priority': 'High',
        'assignedTo': 'Emily Davis',
      },
    ];

    // Filter milestones based on selected filter
    List<Map<String, dynamic>> filteredMilestones = milestones.where((milestone) {
      if (filter == 'All') return true;
      if (filter == 'In Progress') return milestone['status'] == 'In Progress';
      if (filter == 'Completed') return milestone['status'] == 'Completed';
      if (filter == 'Overdue') {
        return milestone['status'] != 'Completed' && 
               milestone['dueDate'].isBefore(DateTime.now());
      }
      return true;
    }).toList();

    // Sort milestones based on selected sort
    filteredMilestones.sort((a, b) {
      if (sortBy == 'Due Date') {
        return a['dueDate'].compareTo(b['dueDate']);
      } else if (sortBy == 'Priority') {
        final priorityOrder = {'High': 0, 'Medium': 1, 'Low': 2};
        return priorityOrder[a['priority']]!.compareTo(priorityOrder[b['priority']]!);
      } else if (sortBy == 'Name') {
        return a['title'].compareTo(b['title']);
      }
      return 0;
    });

    // Hide completed milestones if showCompleted is false
    if (!showCompleted) {
      filteredMilestones = filteredMilestones.where((milestone) => 
        milestone['status'] != 'Completed'
      ).toList();
    }

    if (filteredMilestones.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_turned_in,
              size: 64,
              color: isLightTheme ? Colors.grey[400] : Colors.grey[600],
            ),
            const SizedBox(height: 16),
            Text(
              'No milestones found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isLightTheme ? Colors.grey[600] : Colors.grey[400],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your filters',
              style: TextStyle(
                color: isLightTheme ? Colors.grey[500] : Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isMobile ? 1 : 2,
        childAspectRatio: isMobile ? 1.2 : 1.5,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: filteredMilestones.length,
      itemBuilder: (context, index) {
        final milestone = filteredMilestones[index];
        return MilestoneCard(
          id: milestone['id'],
          title: milestone['title'],
          description: milestone['description'],
          dueDate: milestone['dueDate'],
          status: milestone['status'],
          progress: milestone['progress'],
          priority: milestone['priority'],
          assignedTo: milestone['assignedTo'],
        );
      },
    );
  }
} 