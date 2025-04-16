import 'package:flutter/material.dart';
import 'tabs/material_overview_tab.dart';
import 'tabs/material_management_tab.dart';
import 'tabs/unpaid_materials_tab.dart';
import 'tabs/suppliers_tab.dart';
import '../../theme/app_theme.dart';
import '../../utils/responsive_helper.dart';
import '../../widgets/common/app_sidebar.dart';
import '../../widgets/common/page_header.dart';

class MaterialScreen extends StatefulWidget {
  const MaterialScreen({super.key});

  @override
  State<MaterialScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends State<MaterialScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: [
                // Sidebar - Always visible but collapsible
                const AppSidebar(selectedIndex: 4), // Assuming Material is the 4th item (index 3)
                
                // Main content
                Expanded(
                  child: Column(
                    children: [
                      // Page header with search and profile
                      _buildPageHeader(),
                      
                      // Scrollable main content
                      Expanded(
                        child: Column(
                          children: [
                            _buildTabBar(context),
                            Expanded(
                              child: const TabBarView(
                                children: [
                                  MaterialOverviewTab(),
                                  MaterialManagementTab(),
                                  UnpaidMaterialsTab(),
                                  SuppliersTab(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        // Mobile action buttons - only shown on mobile
        floatingActionButton: ResponsiveHelper.isMobile(context) 
          ? FloatingActionButton(
              onPressed: () {},
              backgroundColor: AppTheme.primaryColor,
              child: const Icon(Icons.add),
            ) 
          : null,
      ),
    );
  }
  
  Widget _buildPageHeader() {
    return PageHeader(
      title: 'Material',
      actions: ResponsiveHelper.isMobile(context) 
        ? [] 
        : [
            // Export button
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.file_download, size: 20),
              label: const Text('Export'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.grey[400],
                side: BorderSide(color: Colors.grey[700]!),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
            const SizedBox(width: 16),
            // Add New Material button
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add, size: 20),
              label: const Text('Add Material'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
          ],
    );
  }
  
  Widget _buildTabBar(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isTablet = ResponsiveHelper.isTablet(context);
    
    return Container(
      height: 48,
      color: Theme.of(context).cardColor,
      child: TabBar(
        isScrollable: isMobile || isTablet,
        tabs: const [
          Tab(text: 'Overview'),
          Tab(text: 'Material Management'),
          Tab(text: 'Unpaid Materials'),
          Tab(text: 'Suppliers'),
        ],
        indicatorColor: AppTheme.primaryColor,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey[400],
      ),
    );
  }
}