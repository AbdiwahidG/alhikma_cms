import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/project_provider.dart';
import '../../widgets/cards/project_card.dart';

class ProjectsListScreen extends StatefulWidget {
  const ProjectsListScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsListScreen> createState() => _ProjectsListScreenState();
}

class _ProjectsListScreenState extends State<ProjectsListScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize projects when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProjectProvider>().initializeProjects();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Implement add project functionality
            },
          ),
        ],
      ),
      body: Consumer<ProjectProvider>(
        builder: (context, projectProvider, child) {
          final projects = projectProvider.projects;
          
          if (projects.isEmpty) {
            return const Center(
              child: Text('No projects available'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              return ProjectCard(
                title: project.name,
                description: project.description,
                startDate: project.startDate,
                endDate: project.endDate,
                status: project.status,
                progress: project.progress,
                onViewDetails: () {
                  // Select the project and navigate to its dashboard
                  projectProvider.selectProject(project.id);
                  Navigator.pushNamed(
                    context,
                    '/project/dashboard',
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
} 