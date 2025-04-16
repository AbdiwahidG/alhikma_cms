import 'package:alhikma_cms/config/theme.dart';
import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:intl/intl.dart';
// import 'package:alhikma_cms/models/task.dart';
import 'package:alhikma_cms/screens/timeline/calendar_view.dart';
import 'package:alhikma_cms/screens/timeline/gantt_view.dart';
import 'package:alhikma_cms/screens/timeline/list_view.dart';
import 'package:alhikma_cms/widgets/common/app_sidebar.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;
  String _currentView = 'Calendar';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        if (_tabController.index == 0) {
          _currentView = 'Calendar';
        } else if (_tabController.index == 1) {
          _currentView = 'Gantt';
        } else {
          _currentView = 'List';
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    // Use actual theme from context instead of hardcoded value
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor:
          isLightTheme ? AppTheme.lightBackground : AppTheme.darkBackground,
      drawer: isMobile ? const AppSidebar(selectedIndex: 1, isDrawer: true) : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMobile) const AppSidebar(selectedIndex: 1),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  _buildHeader(isMobile, isLightTheme),

                  // Tab bar
                  _buildImprovedTabBar(isLightTheme),
                  // Search and filter
                  _buildSearchAndFilter(isLightTheme),

                  // Tab content
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        CalendarView(),
                        GanttView(),
                        TimelineListView(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.primaryColor,
        child: const Icon(Icons.add),
        onPressed: () {
          _showAddTaskDialog(isLightTheme);
        },
      ),
    );
  }

  Widget _buildImprovedTabBar(bool isLightTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: isLightTheme ? Colors.grey.shade300 : Colors.grey.shade700),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: isLightTheme ? Colors.black87 : Colors.white70,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'Calendar'),
              Tab(text: 'Gantt'),
              Tab(text: 'List'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(bool isMobile, bool isLightTheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
      child: Row(
        children: [
          if (isMobile)
            IconButton(
              icon: Icon(
                Icons.menu,
                color:
                    isLightTheme
                        ? AppTheme.lightTextColor
                        : AppTheme.darkTextColor,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          Text(
            'Timeline',
            style: TextStyle(
              color:
                  isLightTheme
                      ? AppTheme.lightTextColor
                      : AppTheme.darkTextColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          TextButton.icon(
            icon: Icon(
              Icons.dashboard,
              color:
                  isLightTheme
                      ? AppTheme.lightTextColor
                      : AppTheme.darkTextColor,
            ),
            label: Text(
              'Dashboard',
              style: TextStyle(
                color:
                    isLightTheme
                        ? AppTheme.lightTextColor
                        : AppTheme.darkTextColor,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
          ),
          Icon(
            Icons.chevron_right,
            color:
                isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
          ),
          TextButton.icon(
            icon: Icon(
              Icons.timeline,
              color:
                  isLightTheme
                      ? AppTheme.lightTextColor
                      : AppTheme.darkTextColor,
            ),
            label: Text(
              'Timeline',
              style: TextStyle(
                color:
                    isLightTheme
                        ? AppTheme.lightTextColor
                        : AppTheme.darkTextColor,
              ),
            ),
            onPressed: () {},
          ),
          if (_currentView != 'Calendar')
            Row(
              children: [
                Icon(
                  Icons.chevron_right,
                  color:
                      isLightTheme
                          ? AppTheme.lightTextColor
                          : AppTheme.darkTextColor,
                ),
                TextButton.icon(
                  icon: Icon(
                    _currentView == 'Gantt'
                        ? Icons.stacked_bar_chart
                        : Icons.list,
                    color:
                        isLightTheme
                            ? AppTheme.lightTextColor
                            : AppTheme.darkTextColor,
                  ),
                  label: Text(
                    _currentView,
                    style: TextStyle(
                      color:
                          isLightTheme
                              ? AppTheme.lightTextColor
                              : AppTheme.darkTextColor,
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(bool isLightTheme) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
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
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search timelines...',
                hintStyle: TextStyle(
                  color: isLightTheme ? Colors.black38 : Colors.white38,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: isLightTheme ? Colors.black54 : Colors.white54,
                ),
                filled: true,
                fillColor:
                    isLightTheme ? Colors.grey[200] : const Color(0xFF2A2A2A),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(
                color:
                    isLightTheme
                        ? AppTheme.lightTextColor
                        : AppTheme.darkTextColor,
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            icon: const Icon(Icons.calendar_today, size: 18),
            label: const Text('Select Date'),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  isLightTheme ? Colors.grey[200] : const Color(0xFF2A2A2A),
              foregroundColor:
                  isLightTheme
                      ? AppTheme.lightTextColor
                      : AppTheme.darkTextColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            onPressed: () {
              // Show date picker
            },
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isLightTheme ? Colors.grey[200] : const Color(0xFF2A2A2A),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: Icon(
                Icons.filter_list,
                color:
                    isLightTheme
                        ? AppTheme.lightTextColor
                        : AppTheme.darkTextColor,
              ),
              onPressed: () {
                // Show filter options
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(bool isLightTheme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor:
              isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
          title: Text(
            'Add New Task',
            style: TextStyle(
              color:
                  isLightTheme
                      ? AppTheme.lightTextColor
                      : AppTheme.darkTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Task Name',
                    labelStyle: TextStyle(
                      color: isLightTheme ? Colors.black54 : Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isLightTheme ? Colors.grey : Colors.grey[600]!,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primaryColor),
                    ),
                  ),
                  style: TextStyle(
                    color:
                        isLightTheme
                            ? AppTheme.lightTextColor
                            : AppTheme.darkTextColor,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Start Date',
                    labelStyle: TextStyle(
                      color: isLightTheme ? Colors.black54 : Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isLightTheme ? Colors.grey : Colors.grey[600]!,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primaryColor),
                    ),
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: isLightTheme ? Colors.black54 : Colors.grey[400],
                    ),
                  ),
                  style: TextStyle(
                    color:
                        isLightTheme
                            ? AppTheme.lightTextColor
                            : AppTheme.darkTextColor,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'End Date',
                    labelStyle: TextStyle(
                      color: isLightTheme ? Colors.black54 : Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isLightTheme ? Colors.grey : Colors.grey[600]!,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primaryColor),
                    ),
                    suffixIcon: Icon(
                      Icons.calendar_today,
                      color: isLightTheme ? Colors.black54 : Colors.grey[400],
                    ),
                  ),
                  style: TextStyle(
                    color:
                        isLightTheme
                            ? AppTheme.lightTextColor
                            : AppTheme.darkTextColor,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: TextStyle(
                      color: isLightTheme ? Colors.black54 : Colors.grey[400],
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: isLightTheme ? Colors.grey : Colors.grey[600]!,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppTheme.primaryColor),
                    ),
                  ),
                  dropdownColor:
                      isLightTheme
                          ? AppTheme.lightSurface
                          : AppTheme.darkSurface,
                  items: [
                    DropdownMenuItem(
                      value: 'Site Prep',
                      child: Text(
                        'Site Prep',
                        style: TextStyle(
                          color:
                              isLightTheme
                                  ? AppTheme.lightTextColor
                                  : AppTheme.darkTextColor,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Foundation',
                      child: Text(
                        'Foundation',
                        style: TextStyle(
                          color:
                              isLightTheme
                                  ? AppTheme.lightTextColor
                                  : AppTheme.darkTextColor,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Steel Framework',
                      child: Text(
                        'Steel Framework',
                        style: TextStyle(
                          color:
                              isLightTheme
                                  ? AppTheme.lightTextColor
                                  : AppTheme.darkTextColor,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Electrical',
                      child: Text(
                        'Electrical',
                        style: TextStyle(
                          color:
                              isLightTheme
                                  ? AppTheme.lightTextColor
                                  : AppTheme.darkTextColor,
                        ),
                      ),
                    ),
                    DropdownMenuItem(
                      value: 'Masonry & Finish',
                      child: Text(
                        'Masonry & Finish',
                        style: TextStyle(
                          color:
                              isLightTheme
                                  ? AppTheme.lightTextColor
                                  : AppTheme.darkTextColor,
                        ),
                      ),
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isLightTheme ? Colors.black54 : Colors.grey[400],
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
              ),
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
