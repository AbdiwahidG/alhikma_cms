import 'package:flutter/material.dart';
import 'package:alhikma_cms/config/theme.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';
import 'package:alhikma_cms/widgets/common/app_sidebar.dart';
import 'package:alhikma_cms/screens/labour/tabs/overview_tab.dart';
import 'package:alhikma_cms/screens/labour/tabs/weekly_wages_tab.dart';
import 'package:alhikma_cms/screens/labour/tabs/professional_tab.dart';
import 'package:alhikma_cms/screens/labour/tabs/salaries_tab.dart';
import 'package:alhikma_cms/screens/labour/tabs/miscellaneous_tab.dart';

class LaborScreen extends StatefulWidget {
  const LaborScreen({super.key});

  @override
  _LaborScreenState createState() => _LaborScreenState();
}

class _LaborScreenState extends State<LaborScreen> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: isLightTheme ? AppTheme.lightBackground : AppTheme.darkBackground,
      drawer: isMobile ? const AppSidebar(selectedIndex: 3, isDrawer: true) : null,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMobile) const AppSidebar(selectedIndex: 3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(isMobile, isLightTheme),
                  _buildTabBar(isLightTheme),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: const [
                        OverviewTab(),
                        WeeklyWagesTab(),
                        ProfessionalTab(),
                        SalariesTab(),
                        MiscellaneousTab(),
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
          _showAddWorkerDialog(isLightTheme);
        },
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
                color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
              ),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          Text(
            'Labour',
            style: TextStyle(
              color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          TextButton.icon(
            icon: Icon(
              Icons.dashboard,
              color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
            ),
            label: Text(
              'Dashboard',
              style: TextStyle(
                color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
          ),
          Icon(
            Icons.chevron_right,
            color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
          ),
          TextButton.icon(
            icon: Icon(
              Icons.people,
              color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
            ),
            label: Text(
              'Labour',
              style: TextStyle(
                color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
              ),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(bool isLightTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isLightTheme ? Colors.grey.shade300 : Colors.grey.shade700,
          ),
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
            tabs: const [
              Tab(text: 'Overview'),
              Tab(text: 'Weekly wages'),
              Tab(text: 'Professional'),
              Tab(text: 'Salaries'),
              Tab(text: 'Miscellaneous'),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddWorkerDialog(bool isLightTheme) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
          title: Text(
            'Add New Worker',
            style: TextStyle(
              color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
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
                    labelText: 'Full Name',
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
                    color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Position',
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
                  dropdownColor: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
                  items: [
                    'Foreman',
                    'Assistant',
                    'Carpenter',
                    'Mason',
                    'Helper',
                    'Steel Fixer',
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {},
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Daily Rate',
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
                    prefixText: '\$ ',
                  ),
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
                  ),
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