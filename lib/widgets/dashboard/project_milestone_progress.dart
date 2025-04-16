import 'package:flutter/material.dart';

class ProjectMilestoneProgress extends StatelessWidget {
  const ProjectMilestoneProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if we're on a small screen
        final isSmallScreen = constraints.maxWidth < 600;
        
        return Card(
          child: Padding(
            padding: EdgeInsets.all(isSmallScreen ? 12.0 : 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Project Milestones',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _buildMilestoneItem(
                  context,
                  title: 'Foundation Work',
                  progress: 0.9,
                  status: 'Completed',
                  date: 'Mar 15, 2024',
                  isCompleted: true,
                  isSmallScreen: isSmallScreen,
                ),
                _buildMilestoneItem(
                  context,
                  title: 'Structural Framework',
                  progress: 0.7,
                  status: 'In Progress',
                  date: 'Apr 30, 2024',
                  isCompleted: false,
                  isSmallScreen: isSmallScreen,
                ),
                _buildMilestoneItem(
                  context,
                  title: 'Interior Finishing',
                  progress: 0.3,
                  status: 'Upcoming',
                  date: 'Jun 15, 2024',
                  isCompleted: false,
                  isSmallScreen: isSmallScreen,
                ),
                _buildMilestoneItem(
                  context,
                  title: 'Final Inspection',
                  progress: 0.0,
                  status: 'Upcoming',
                  date: 'Jul 30, 2024',
                  isCompleted: false,
                  isSmallScreen: isSmallScreen,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMilestoneItem(
    BuildContext context, {
    required String title,
    required double progress,
    required String status,
    required String date,
    required bool isCompleted,
    required bool isSmallScreen,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isSmallScreen ? 6.0 : 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCompleted ? Icons.check_circle : Icons.circle_outlined,
                color: isCompleted ? Colors.green : Colors.grey,
                size: isSmallScreen ? 18 : 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isSmallScreen ? 14 : 16,
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: isSmallScreen ? 10 : 12,
                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isSmallScreen ? 6 : 8, 
                  vertical: isSmallScreen ? 2 : 4
                ),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.green.withOpacity(0.1)
                      : Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: isSmallScreen ? 10 : 12,
                    color: isCompleted ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              isCompleted ? Colors.green : Theme.of(context).colorScheme.primary,
            ),
            minHeight: isSmallScreen ? 4 : 6,
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
} 