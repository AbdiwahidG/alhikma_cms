import 'package:alhikma_cms/widgets/common/app_sidebar.dart';
import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../utils/responsive_helper.dart';

import 'tabs/overview_tab.dart';
import 'tabs/income_tab.dart';
import 'tabs/expenses_tab.dart';
import 'tabs/budget_tab.dart';
import 'tabs/reports_tab.dart';

class FinancialScreen extends StatefulWidget {
  const FinancialScreen({super.key});

  @override
  State<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final textColor = isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor;
    final isMobile = ResponsiveHelper.isMobile(context);
    final isTablet = ResponsiveHelper.isTablet(context);
    
    return Scaffold(
      key: _scaffoldKey,
      drawer: const  AppSidebar(selectedIndex: 5),
      appBar: AppBar(
        backgroundColor: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        title: Text(
          'Financial Management',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // Show notifications
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Show profile
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
            child: TabBar(
              controller: _tabController,
              isScrollable: isMobile || isTablet,
              labelColor: AppTheme.primaryColor,
              unselectedLabelColor: textColor.withOpacity(0.7),
              indicatorColor: AppTheme.primaryColor,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Income'),
                Tab(text: 'Expenses'),
                Tab(text: 'Budget'),
                Tab(text: 'Reports'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                OverviewTab(),
                IncomeTab(),
                ExpensesTab(),
                BudgetTab(),
                ReportsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
} 