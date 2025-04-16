import 'package:alhikma_cms/screens/financials/tabs/budget_tab.dart';
import 'package:alhikma_cms/screens/financials/tabs/expenses_tab.dart';
import 'package:alhikma_cms/screens/financials/tabs/income_tab.dart';
import 'package:alhikma_cms/screens/financials/tabs/overview_tab.dart';
import 'package:alhikma_cms/widgets/common/app_sidebar.dart';
import 'package:flutter/material.dart';
import '../../config/theme.dart';
import '../../utils/responsive_helper.dart';

import 'tabs/reports_tab.dart';

class FinancialScreen extends StatefulWidget {
  const FinancialScreen({super.key});

  @override
  State<FinancialScreen> createState() => _FinancialScreenState();
}

class _FinancialScreenState extends State<FinancialScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
// Financial section index

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
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isTablet = ResponsiveHelper.isTablet(context);
    
    return Scaffold(
      backgroundColor: isLightTheme ? AppTheme.lightBackground : AppTheme.darkBackground,
      body: Row(
        children: [
          // Sidebar
          const AppSidebar(selectedIndex: 5),
          
          // Main content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Financial Management',
                        style: TextStyle(
                          color: textColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Track and manage your company finances',
                        style: TextStyle(
                          color: textColor.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Tabs
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
                
                // Tab content
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
          ),
        ],
      ),
    );
  }
} 