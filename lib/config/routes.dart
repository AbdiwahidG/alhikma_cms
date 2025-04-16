import 'package:alhikma_cms/screens/financial/financial_screen.dart';

import 'package:alhikma_cms/screens/labour/labour_screen.dart';
import 'package:alhikma_cms/screens/material/material_screen.dart';
import 'package:alhikma_cms/screens/settings/help_screen.dart';
import 'package:alhikma_cms/screens/timeline/timeline_screen.dart';
import 'package:flutter/material.dart';
import 'package:alhikma_cms/screens/auth/reset_password_screen.dart';
import 'package:alhikma_cms/screens/auth/sign_in_screen.dart';
import 'package:alhikma_cms/screens/auth/sign_up_screen.dart';
import 'package:alhikma_cms/screens/dashboard/dashboard_screen.dart';
import 'package:alhikma_cms/screens/milestones/milestones_screen.dart';
import 'package:alhikma_cms/screens/projects/add_project_screen.dart';
import 'package:alhikma_cms/screens/projects/projects_screen.dart';
import 'package:alhikma_cms/screens/settings/settings_screen.dart';

class AppRoutes {
  // Auth routes
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String resetPassword = '/reset-password';
  
  // Project routes
  static const String projects = '/projects';
  static const String addProject = '/projects/new';
  
  // Dashboard route
  static const String dashboard = '/dashboard';
  
  // Timeline routes
  static const String timeline = '/timeline';
  
  // Milestone routes
  static const String milestones = '/milestones';
  
  // Labour routes
  static const String labour = '/labour';
  
  // Materials routes
  static const String materials = '/materials';
  
  // Financials routes
  static const String financials = '/financial';
  
  // Settings routes
  static const String settings = '/settings';

  // Help routes
  static const String help = '/help';
  
  // Route mapping
  static Map<String, WidgetBuilder> get routes => {
    signIn: (context) => const SignInScreen(),
    signUp: (context) => const SignUpScreen(),
    resetPassword: (context) => const ResetPasswordScreen(),
    projects: (context) => const ProjectsScreen(),
    addProject: (context) => const AddProjectScreen(),
    dashboard: (context) => const DashboardScreen(),
    timeline: (context) => const TimelineScreen(),
    milestones: (context) => const MilestonesScreen(),
    labour: (context) => const LaborScreen(),
    materials: (context) => const MaterialScreen(),
    financials: (context) => const FinancialScreen(),
    settings: (context) => const SettingsScreen(),
    help: (context) => const HelpScreen(),
  };
}