import 'package:flutter/material.dart';

class Project {
  final String id;
  final String name;
  final String description;
  final String status;
  final double progress;
  final DateTime startDate;
  final DateTime endDate;

  Project({
    required this.id,
    required this.name,
    required this.description,
    required this.status,
    required this.progress,
    required this.startDate,
    required this.endDate,
  });
}

class ProjectProvider extends ChangeNotifier {
  Project? _selectedProject;
  List<Project> _projects = [];

  Project? get selectedProject => _selectedProject;
  List<Project> get projects => _projects;

  // Initialize with sample projects
  void initializeProjects() {
    _projects = [
      Project(
        id: '1',
        name: 'Al-Hikma Mosque',
        description: 'Main mosque construction project',
        status: 'In Progress',
        progress: 0.65,
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 12, 31),
      ),
      Project(
        id: '2',
        name: 'Community Center',
        description: 'Multi-purpose community center',
        status: 'Planning',
        progress: 0.25,
        startDate: DateTime(2024, 3, 1),
        endDate: DateTime(2025, 2, 28),
      ),
      Project(
        id: '3',
        name: 'Education Wing',
        description: 'Educational facilities expansion',
        status: 'Completed',
        progress: 1.0,
        startDate: DateTime(2023, 6, 1),
        endDate: DateTime(2024, 1, 31),
      ),
    ];
    notifyListeners();
  }

  void selectProject(String projectId) {
    _selectedProject = _projects.firstWhere(
      (project) => project.id == projectId,
      orElse: () => throw Exception('Project not found'),
    );
    notifyListeners();
  }

  void clearSelectedProject() {
    _selectedProject = null;
    notifyListeners();
  }

  bool get isProjectSelected => _selectedProject != null;
} 