import 'package:flutter/material.dart';
import 'package:alhikma_cms/screens/labour/tabs/miscellaneous_tab.dart';
import 'package:alhikma_cms/screens/labour/tabs/overview_tab.dart';
import 'package:alhikma_cms/screens/labour/tabs/professional_tab.dart';
import 'package:alhikma_cms/screens/labour/tabs/salaries_tab.dart';
import 'package:alhikma_cms/widgets/layout/app_sidebar.dart';

class LaborScreen extends StatelessWidget {
  const LaborScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Labor Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Overview'),
              Tab(text: 'Professional'),
              Tab(text: 'Salaries'),
              Tab(text: 'Miscellaneous'),
            ],
          ),
        ),
        drawer: const AppSidebar(),
        body: const TabBarView(
          children: [
            OverviewTab(),
            ProfessionalTab(),
            SalariesTab(),
            MiscellaneousTab(),
          ],
        ),
      ),
    );
  }
} 