import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:alhikma_cms/config/theme.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';
import 'package:alhikma_cms/widgets/common/app_sidebar.dart';

class MilestoneDetailsScreen extends StatefulWidget {
  final String milestoneId;

  const MilestoneDetailsScreen({
    super.key,
    required this.milestoneId,
  });

  @override
  State<MilestoneDetailsScreen> createState() => _MilestoneDetailsScreenState();
}

class _MilestoneDetailsScreenState extends State<MilestoneDetailsScreen> {
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();
  
  // Form controllers
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _assignedToController;
  late DateTime _dueDate;
  late String _status;
  late String _priority;

  @override
  void initState() {
    super.initState();
    // In a real app, you would fetch the milestone data from an API or database
    // For now, we'll use mock data
    _titleController = TextEditingController(text: 'Site Preparation');
    _descriptionController = TextEditingController(text: 'Complete site clearing and excavation');
    _assignedToController = TextEditingController(text: 'John Doe');
    _dueDate = DateTime.now().add(const Duration(days: 15));
    _status = 'In Progress';
    _priority = 'High';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _assignedToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      appBar: isMobile ? AppBar(
        title: const Text('Milestone Details'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                // Save changes
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isEditing = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Milestone updated successfully')),
                  );
                }
              } else {
                setState(() {
                  _isEditing = true;
                });
              }
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
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMobile)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Milestone Details',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              if (_isEditing) {
                                // Save changes
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _isEditing = false;
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Milestone updated successfully')),
                                  );
                                }
                              } else {
                                setState(() {
                                  _isEditing = true;
                                });
                              }
                            },
                            icon: Icon(_isEditing ? Icons.save : Icons.edit),
                            label: Text(_isEditing ? 'Save Changes' : 'Edit Milestone'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildFormField(
                              label: 'Title',
                              controller: _titleController,
                              enabled: _isEditing,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a title';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            _buildFormField(
                              label: 'Description',
                              controller: _descriptionController,
                              enabled: _isEditing,
                              maxLines: 3,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a description';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildFormField(
                                    label: 'Assigned To',
                                    controller: _assignedToController,
                                    enabled: _isEditing,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter an assignee';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: _buildDateField(
                                    label: 'Due Date',
                                    value: _dueDate,
                                    enabled: _isEditing,
                                    onChanged: (date) {
                                      setState(() {
                                        _dueDate = date;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildDropdownField(
                                    label: 'Status',
                                    value: _status,
                                    items: ['Not Started', 'In Progress', 'Completed'],
                                    enabled: _isEditing,
                                    onChanged: (value) {
                                      setState(() {
                                        _status = value!;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: _buildDropdownField(
                                    label: 'Priority',
                                    value: _priority,
                                    items: ['Low', 'Medium', 'High'],
                                    enabled: _isEditing,
                                    onChanged: (value) {
                                      setState(() {
                                        _priority = value!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),
                            _buildProgressSection(isLightTheme),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTasksSection(isLightTheme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required TextEditingController controller,
    required bool enabled,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          enabled: enabled,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildDateField({
    required String label,
    required DateTime value,
    required bool enabled,
    required Function(DateTime) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: enabled ? () async {
            final DateTime? picked = await showDatePicker(
              context: context,
              initialDate: value,
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 365)),
            );
            if (picked != null) {
              onChanged(picked);
            }
          } : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('MMM d, y').format(value),
                  style: TextStyle(
                    color: enabled ? null : Colors.grey,
                  ),
                ),
                if (enabled)
                  const Icon(Icons.calendar_today, size: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required bool enabled,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: const Icon(Icons.arrow_drop_down),
              style: TextStyle(
                color: enabled ? null : Colors.grey,
              ),
              items: items.map<DropdownMenuItem<String>>((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: enabled ? onChanged : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection(bool isLightTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Progress',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 16),
        LinearProgressIndicator(
          value: 0.6,
          backgroundColor: isLightTheme ? Colors.grey[200] : Colors.grey[800],
          valueColor: AlwaysStoppedAnimation<Color>(_getProgressColor(_status)),
          minHeight: 10,
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '60% Complete',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: (isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor).withOpacity(0.7),
              ),
            ),
            if (_isEditing)
              ElevatedButton(
                onPressed: () {
                  // Show progress update dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Update Progress'),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTasksSection(bool isLightTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Tasks',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            if (_isEditing)
              ElevatedButton.icon(
                onPressed: () {
                  // Show add task dialog
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Task'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return ListTile(
                leading: Checkbox(
                  value: index == 0,
                  onChanged: _isEditing ? (value) {
                    // Update task status
                  } : null,
                  activeColor: AppTheme.primaryColor,
                ),
                title: Text(
                  index == 0 ? 'Clear site debris' : 
                  index == 1 ? 'Excavate foundation area' : 
                  'Level the ground',
                  style: TextStyle(
                    decoration: index == 0 ? TextDecoration.lineThrough : null,
                    color: index == 0 ? Colors.grey : null,
                  ),
                ),
                subtitle: Text(
                  index == 0 ? 'Completed on May 15, 2023' : 
                  'Due by May 20, 2023',
                ),
                trailing: _isEditing ? IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    // Delete task
                  },
                ) : null,
              );
            },
          ),
        ),
      ],
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