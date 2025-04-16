import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/project_provider.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final projectProvider = context.watch<ProjectProvider>();
    final selectedProject = projectProvider.selectedProject;

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Al-Hikma CMS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (selectedProject != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    selectedProject.name,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                ],
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () {
              if (selectedProject != null) {
                Navigator.pushNamed(context, '/project/dashboard');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory),
            title: const Text('Materials'),
            onTap: () {
              if (selectedProject != null) {
                Navigator.pushNamed(context, '/project/materials');
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Labor'),
            onTap: () {
              if (selectedProject != null) {
                Navigator.pushNamed(context, '/project/labor');
              }
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.folder),
            title: const Text('All Projects'),
            onTap: () {
              projectProvider.clearSelectedProject();
              Navigator.pushNamed(context, '/projects');
            },
          ),
        ],
      ),
    );
  }
} 