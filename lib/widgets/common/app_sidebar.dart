import 'package:flutter/material.dart';
import 'package:alhikma_cms/config/routes.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';

class AppSidebar extends StatefulWidget {
  final int selectedIndex;
  final bool isDrawer;

  const AppSidebar({
    super.key, 
    required this.selectedIndex,
    this.isDrawer = false,
  });

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  bool _isCollapsed = false;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    ResponsiveHelper.isMobile(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: _isCollapsed ? 80 : 300,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Logo and app name with hamburger menu on right side for mobile
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: _isCollapsed 
                  ? MainAxisAlignment.center 
                  : MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      isDarkMode ? 'assets/images/logo_dark.png' : 'assets/images/logo_light.png',
                      width: 40,
                      height: 40,
                    ),
                    if (!_isCollapsed) ...[
                      const SizedBox(width: 12),
                      Text(
                        'Al-Hikma CMS',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ],
                ),
                // Hamburger menu icon on the right side
                if (!_isCollapsed)
                  IconButton(
                    icon: Icon(
                      _isCollapsed ? Icons.menu_open : Icons.menu,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    onPressed: () {
                      setState(() {
                        _isCollapsed = !_isCollapsed;
                      });
                    },
                  ),
              ],
            ),
          ),

          // Project name with dropdown
          if (!_isCollapsed)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.folder, size: 20),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Project Alpha',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        // Show project selection dialog
                      },
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 24),

          // Navigation items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildNavItem(
                  context,
                  icon: Icons.dashboard,
                  label: 'Dashboard',
                  isSelected: widget.selectedIndex == 0,
                  onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.dashboard),
                ),
                _buildNavItem(
                  context,
                  icon: Icons.timeline,
                  label: 'Timeline',
                  isSelected: widget.selectedIndex == 1,
                  onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.timeline),
                ),
                _buildNavItem(
                  context,
                  icon: Icons.flag,
                  label: 'Milestones',
                  isSelected: widget.selectedIndex == 2,
                  onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.milestones),
                ),
                _buildNavItem(
                  context,
                  icon: Icons.people,
                  label: 'Labour',
                  isSelected: widget.selectedIndex == 3,
                  onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.labour),
                ),
                _buildNavItem(
                  context,
                  icon: Icons.inventory,
                  label: 'Materials',
                  isSelected: widget.selectedIndex == 4,
                  onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.materials),
                ),
                _buildNavItem(
                  context,
                  icon: Icons.attach_money,
                  label: 'Financials',
                  isSelected: widget.selectedIndex == 5,
                  onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.financials),
                ),
                _buildNavItem(
                  context,
                  icon: Icons.settings,
                  label: 'Settings',
                  isSelected: widget.selectedIndex == 6,
                  onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.settings),
                ),
                _buildNavItem(
                  context,
                  icon: Icons.help,
                  label: 'Help',
                  isSelected: widget.selectedIndex == 7,
                  onTap: () => Navigator.pushReplacementNamed(context, AppRoutes.help),
                ),
              ],
            ),
          ),

          // User profile section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _isCollapsed
                ? CircleAvatar(
                    radius: 20,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: const Text(
                      'JD',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                : Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const Text(
                          'JD',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'John Doe',
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'john.doe@example.com',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                  ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          // Show user menu
                        },
                      ),
                    ],
                  ),
          ),

          // Only show expand button when collapsed
          if (_isCollapsed)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _isCollapsed = false;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.chevron_right,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary.withOpacity(0.1)
              : Colors.transparent,
          border: Border(
            left: BorderSide(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
            if (!_isCollapsed) ...[
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}