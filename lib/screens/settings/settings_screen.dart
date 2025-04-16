import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alhikma_cms/config/theme.dart';
import 'package:alhikma_cms/utils/responsive_helper.dart';
import 'package:alhikma_cms/providers/theme_provider.dart';
import 'package:alhikma_cms/widgets/common/app_sidebar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveHelper.isMobile(context);
    final bool isLightTheme = Theme.of(context).brightness == Brightness.light;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: isMobile ? AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // Save settings logic
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings saved')),
              );
            },
          ),
        ],
      ) : null,
      drawer: isMobile ? const Drawer(
        child: AppSidebar(selectedIndex: 6,),
      ) : null,
      body: Row(
        children: [
          if (!isMobile) 
            const AppSidebar(selectedIndex: 6,),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isMobile ? 16.0 : 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMobile)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              // Save settings logic
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Settings saved')),
                              );
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('Save Changes'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  _buildSectionHeader('Appearance', isLightTheme),
                  _buildCard(
                    child: Column(
                      children: [
                        _buildSwitchTile(
                          'Dark Mode',
                          'Enable dark theme',
                          themeProvider.isDarkMode,
                          (value) => themeProvider.toggleTheme(),
                          isLightTheme,
                        ),
                        const Divider(),
                        _buildDropdownTile(
                          'Language',
                          _selectedLanguage,
                          ['English', 'Spanish', 'French', 'German', 'Arabic'],
                          (value) => setState(() => _selectedLanguage = value!),
                          isLightTheme,
                        ),
                      ],
                    ),
                    isLightTheme: isLightTheme,
                  ),
                  
                  const SizedBox(height: 24),
                  _buildSectionHeader('User Management', isLightTheme),
                  _buildCard(
                    child: Column(
                      children: [
                        _buildListTile(
                          'Profile Information',
                          'Update your personal information',
                          Icons.person,
                          () {
                            // Navigate to profile edit screen
                          },
                          isLightTheme,
                        ),
                        const Divider(),
                        _buildListTile(
                          'Security',
                          'Change password and security settings',
                          Icons.security,
                          () {
                            // Navigate to security settings
                          },
                          isLightTheme,
                        ),
                        const Divider(),
                        _buildListTile(
                          'User Roles',
                          'Manage user roles and permissions',
                          Icons.people,
                          () {
                            // Navigate to user roles management
                          },
                          isLightTheme,
                        ),
                        const Divider(),
                        _buildListTile(
                          'User List',
                          'View and manage all users',
                          Icons.group,
                          () {
                            // Navigate to user list
                          },
                          isLightTheme,
                        ),
                      ],
                    ),
                    isLightTheme: isLightTheme,
                  ),
                  
                  const SizedBox(height: 32),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Logout logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.errorColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      child: const Text('Logout'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isLightTheme) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child, required bool isLightTheme}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: child,
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
    bool isLightTheme, {
    bool enabled = true,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: (isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor).withOpacity(0.7),
        ),
      ),
      value: value,
      onChanged: enabled ? onChanged : null,
      activeColor: AppTheme.primaryColor,
    );
  }

  Widget _buildDropdownTile(
    String title,
    String value,
    List<String> items,
    Function(String?) onChanged,
    bool isLightTheme,
  ) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: DropdownButton<String>(
        value: value,
        underline: Container(),
        style: TextStyle(
          color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
        ),
        dropdownColor: isLightTheme ? AppTheme.lightSurface : AppTheme.darkSurface,
        items: items.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildListTile(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback? onTap,
    bool isLightTheme,
  ) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: (isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor).withOpacity(0.7),
        ),
      ),
      trailing: onTap != null
          ? Icon(
              Icons.chevron_right,
              color: isLightTheme ? AppTheme.lightTextColor : AppTheme.darkTextColor,
            )
          : null,
      onTap: onTap,
    );
  }
}