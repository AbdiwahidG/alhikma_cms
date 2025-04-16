import 'package:flutter/material.dart';
import 'package:alhikma_cms/config/theme.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';
import 'package:alhikma_cms/widgets/common/app_sidebar.dart';
import 'package:alhikma_cms/widgets/milestones/milestone_list.dart';
import 'package:alhikma_cms/widgets/milestones/milestone_filters.dart';

class MilestonesScreen extends StatefulWidget {
  const MilestonesScreen({super.key});

  @override
  State<MilestonesScreen> createState() => _MilestonesScreenState();
}

class _MilestonesScreenState extends State<MilestonesScreen> {
  String _selectedFilter = 'All';
  String _selectedSort = 'Due Date';
  bool _showCompleted = true;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    //final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: isMobile ? AppBar(
        title: const Text('Milestones'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              _showFilterDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to add milestone screen
            },
          ),
        ],
      ) : null,
      drawer: isMobile ? const Drawer(
        child: AppSidebar(selectedIndex: 2,),
      ) : null,
      body: Row(
        children: [
          if (!isMobile) 
            const AppSidebar(selectedIndex: 2,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMobile)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Milestones',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {
                                _showFilterDialog(context);
                              },
                              icon: const Icon(Icons.filter_list),
                              label: const Text('Filter'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppTheme.primaryColor,
                                side: const BorderSide(color: AppTheme.primaryColor),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton.icon(
                              onPressed: () {
                                // Navigate to add milestone screen
                              },
                              icon: const Icon(Icons.add),
                              label: const Text('Add Milestone'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryColor,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                if (!isMobile)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: MilestoneFilters(
                      selectedFilter: _selectedFilter,
                      selectedSort: _selectedSort,
                      showCompleted: _showCompleted,
                      onFilterChanged: (value) {
                        setState(() {
                          _selectedFilter = value;
                        });
                      },
                      onSortChanged: (value) {
                        setState(() {
                          _selectedSort = value;
                        });
                      },
                      onShowCompletedChanged: (value) {
                        setState(() {
                          _showCompleted = value;
                        });
                      },
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
                    child: MilestoneList(
                      filter: _selectedFilter,
                      sortBy: _selectedSort,
                      showCompleted: _showCompleted,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Filter Milestones'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Filter by:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _buildFilterChip('All', _selectedFilter),
                  _buildFilterChip('In Progress', _selectedFilter),
                  _buildFilterChip('Completed', _selectedFilter),
                  _buildFilterChip('Overdue', _selectedFilter),
                ],
              ),
              const SizedBox(height: 16),
              const Text('Sort by:'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  _buildFilterChip('Due Date', _selectedSort),
                  _buildFilterChip('Priority', _selectedSort),
                  _buildFilterChip('Name', _selectedSort),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('Show completed:'),
                  const SizedBox(width: 8),
                  Switch(
                    value: _showCompleted,
                    onChanged: (value) {
                      setState(() {
                        _showCompleted = value;
                      });
                      Navigator.pop(context);
                    },
                    activeColor: AppTheme.primaryColor,
                  ),
                ],
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Apply'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterChip(String label, String selectedValue) {
    final bool isSelected = label == selectedValue;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (label == 'All' || label == 'In Progress' || label == 'Completed' || label == 'Overdue') {
            _selectedFilter = label;
          } else {
            _selectedSort = label;
          }
        });
      },
      selectedColor: AppTheme.primaryColor.withOpacity(0.2),
      checkmarkColor: AppTheme.primaryColor,
      labelStyle: TextStyle(
        color: isSelected ? AppTheme.primaryColor : null,
        fontWeight: isSelected ? FontWeight.bold : null,
      ),
    );
  }
} 