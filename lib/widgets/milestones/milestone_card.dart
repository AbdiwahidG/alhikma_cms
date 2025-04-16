import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alhikma_cms/config/theme.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';

class MilestoneCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;
  final DateTime dueDate;
  final String status;
  final double progress;
  final String priority;
  final String assignedTo;

  const MilestoneCard({
    super.key,
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.status,
    required this.progress,
    required this.priority,
    required this.assignedTo,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final bool isOverdue = dueDate.isBefore(DateTime.now()) && status != 'Completed';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
      child: InkWell(
        onTap: () {
          // Navigate to milestone details
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(isMobile ? 12.0 : 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: isMobile ? 16 : 18,
                        fontWeight: FontWeight.bold,
                        color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildStatusChip(status, isLightTheme),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: isMobile ? 12 : 14,
                  color: (isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor).withOpacity(0.7),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: progress,
                backgroundColor: isLightTheme ? Colors.grey[200] : Colors.grey[800],
                valueColor: AlwaysStoppedAnimation<Color>(_getProgressColor(status)),
                minHeight: 6,
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${(progress * 100).toInt()}% Complete',
                    style: TextStyle(
                      fontSize: isMobile ? 12 : 14,
                      fontWeight: FontWeight.w500,
                      color: (isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor).withOpacity(0.7),
                    ),
                  ),
                  _buildPriorityChip(priority, isLightTheme),
                ],
              ),
              const Spacer(),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Due Date',
                        style: TextStyle(
                          fontSize: isMobile ? 10 : 12,
                          color: (isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor).withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        DateFormat('MMM d, y').format(dueDate),
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w500,
                          color: isOverdue ? AppTheme.errorColor : (isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Assigned To',
                        style: TextStyle(
                          fontSize: isMobile ? 10 : 12,
                          color: (isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor).withOpacity(0.5),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        assignedTo,
                        style: TextStyle(
                          fontSize: isMobile ? 12 : 14,
                          fontWeight: FontWeight.w500,
                          color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status, bool isLightTheme) {
    Color chipColor;
    Color textColor;

    switch (status) {
      case 'Completed':
        chipColor = AppTheme.successColor.withOpacity(0.2);
        textColor = AppTheme.successColor;
        break;
      case 'In Progress':
        chipColor = AppTheme.primaryColor.withOpacity(0.2);
        textColor = AppTheme.primaryColor;
        break;
      case 'Not Started':
        chipColor = Colors.grey.withOpacity(0.2);
        textColor = isLightTheme ? Colors.grey[700]! : Colors.grey[300]!;
        break;
      default:
        chipColor = Colors.grey.withOpacity(0.2);
        textColor = isLightTheme ? Colors.grey[700]! : Colors.grey[300]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildPriorityChip(String priority, bool isLightTheme) {
    Color chipColor;
    Color textColor;

    switch (priority) {
      case 'High':
        chipColor = AppTheme.errorColor.withOpacity(0.2);
        textColor = AppTheme.errorColor;
        break;
      case 'Medium':
        chipColor = AppTheme.warningColor.withOpacity(0.2);
        textColor = AppTheme.warningColor;
        break;
      case 'Low':
        chipColor = AppTheme.successColor.withOpacity(0.2);
        textColor = AppTheme.successColor;
        break;
      default:
        chipColor = Colors.grey.withOpacity(0.2);
        textColor = isLightTheme ? Colors.grey[700]! : Colors.grey[300]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: chipColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        priority,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }

  Color _getProgressColor(String status) {
    switch (status) {
      case 'Completed':
        return AppTheme.successColor;
      case 'In Progress':
        return AppTheme.primaryColor;
      case 'Not Started':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }
} 