import 'package:flutter/material.dart';
import 'package:alhikma_cms/config/theme.dart';

class MilestoneFilters extends StatelessWidget {
  final String selectedFilter;
  final String selectedSort;
  final bool showCompleted;
  final Function(String) onFilterChanged;
  final Function(String) onSortChanged;
  final Function(bool) onShowCompletedChanged;

  const MilestoneFilters({
    super.key,
    required this.selectedFilter,
    required this.selectedSort,
    required this.showCompleted,
    required this.onFilterChanged,
    required this.onSortChanged,
    required this.onShowCompletedChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Filter by:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                ),
              ),
              const SizedBox(width: 16),
              _buildFilterChip('All', selectedFilter, onFilterChanged),
              _buildFilterChip('In Progress', selectedFilter, onFilterChanged),
              _buildFilterChip('Completed', selectedFilter, onFilterChanged),
              _buildFilterChip('Overdue', selectedFilter, onFilterChanged),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Sort by:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                ),
              ),
              const SizedBox(width: 16),
              _buildFilterChip('Due Date', selectedSort, onSortChanged),
              _buildFilterChip('Priority', selectedSort, onSortChanged),
              _buildFilterChip('Name', selectedSort, onSortChanged),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Show completed:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                ),
              ),
              const SizedBox(width: 8),
              Switch(
                value: showCompleted,
                onChanged: onShowCompletedChanged,
                activeColor: AppTheme.primaryColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String selectedValue, Function(String) onChanged) {
    final bool isSelected = label == selectedValue;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          onChanged(label);
        },
        selectedColor: AppTheme.primaryColor.withOpacity(0.2),
        checkmarkColor: AppTheme.primaryColor,
        labelStyle: TextStyle(
          color: isSelected ? AppTheme.primaryColor : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
    );
  }
} 