import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool darkMode = false;
  bool interviewReminders = true;
  bool applicationReminders = true;
  bool emailNotifications = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
          ),
          color: AppColors.textDark,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(
            16,
            20,
            16,
            30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============================================================
              // APPEARANCE
              // ============================================================

              _sectionTitle('Appearance'),

              _settingsCard(
                children: [
                  _settingsTile(
                    icon: Icons.dark_mode_outlined,
                    iconColor: AppColors.primary,
                    title: 'Dark Mode',
                    trailing: Switch(
                      value: darkMode,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() {
                          darkMode = value;
                        });
                      },
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: AppColors.border,
                  ),
                  _settingsTile(
                    icon: Icons.language_outlined,
                    iconColor: AppColors.blue,
                    title: 'Language',
                    subtitle: 'English',
                    showArrow: true,
                    onTap: () {
                      _showLanguageDialog();
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ============================================================
              // NOTIFICATIONS
              // ============================================================

              _sectionTitle('Notifications'),

              _settingsCard(
                children: [
                  _settingsTile(
                    icon: Icons.event_available_outlined,
                    iconColor: AppColors.green,
                    title: 'Interview Reminders',
                    trailing: Switch(
                      value: interviewReminders,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() {
                          interviewReminders = value;
                        });
                      },
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: AppColors.border,
                  ),
                  _settingsTile(
                    icon: Icons.notifications_active_outlined,
                    iconColor: AppColors.primary,
                    title: 'Application Reminders',
                    trailing: Switch(
                      value: applicationReminders,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() {
                          applicationReminders = value;
                        });
                      },
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: AppColors.border,
                  ),
                  _settingsTile(
                    icon: Icons.email_outlined,
                    iconColor: AppColors.textMedium,
                    title: 'Email Notifications',
                    trailing: Switch(
                      value: emailNotifications,
                      activeColor: AppColors.primary,
                      onChanged: (value) {
                        setState(() {
                          emailNotifications = value;
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ============================================================
              // DATA
              // ============================================================

              _sectionTitle('Data'),

              _settingsCard(
                children: [
                  _settingsTile(
                    icon: Icons.person_outline,
                    iconColor: AppColors.primary,
                    title: 'Export Applications',
                    showArrow: true,
                    onTap: () {
                      _showMessage(
                        'Application data exported successfully.',
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                    color: AppColors.border,
                  ),
                  _settingsTile(
                    icon: Icons.delete_outline,
                    iconColor: AppColors.red,
                    title: 'Clear All Applications',
                    titleColor: AppColors.red,
                    showArrow: true,
                    onTap: () {
                      _showClearConfirmation();
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ============================================================
              // ACCOUNT
              // ============================================================

              _sectionTitle('Account'),

              _settingsCard(
                children: [
                  _settingsTile(
                    icon: Icons.person_outline,
                    iconColor: AppColors.primary,
                    title: 'Edit Profile',
                    showArrow: true,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/profile',
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                    color: AppColors.border,
                  ),
                  _settingsTile(
                    icon: Icons.lock_outline,
                    iconColor: AppColors.purple,
                    title: 'Change Password',
                    showArrow: true,
                    onTap: () {
                      _showMessage(
                        'Change password feature coming soon.',
                      );
                    },
                  ),
                  const Divider(
                    height: 1,
                    color: AppColors.border,
                  ),
                  _settingsTile(
                    icon: Icons.logout,
                    iconColor: AppColors.red,
                    title: 'Logout',
                    titleColor: AppColors.red,
                    showArrow: true,
                    onTap: () {
                      _showLogoutConfirmation();
                    },
                  ),
                ],
              ),

              const SizedBox(height: 30),

              // ============================================================
              // APP VERSION
              // ============================================================

              Center(
                child: Column(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.work_outline,
                        color: AppColors.primary,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'JobTrack',
                      style: TextStyle(
                        color: AppColors.textDark,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Your Job Application Tracker',
                      style: TextStyle(
                        color: AppColors.textMedium,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        color: AppColors.textMedium,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 4,
        bottom: 10,
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.textDark,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // ============================================================
  // SETTINGS CARD
  // ============================================================

  Widget _settingsCard({
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: children,
      ),
    );
  }

  // ============================================================
  // SETTINGS TILE
  // ============================================================

  Widget _settingsTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    Widget? trailing,
    bool showArrow = false,
    Color? titleColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.10),
                borderRadius: BorderRadius.circular(11),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),

            const SizedBox(width: 14),

            // Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor ?? AppColors.textDark,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.textMedium,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            if (trailing != null) trailing,

            if (showArrow)
              const Icon(
                Icons.chevron_right,
                color: AppColors.textMedium,
                size: 21,
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // LANGUAGE DIALOG
  // ============================================================

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            'Language',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                value: 'English',
                groupValue: 'English',
                title: const Text('English'),
                activeColor: AppColors.primary,
                onChanged: (_) {
                  Navigator.pop(context);
                },
              ),
              RadioListTile<String>(
                value: 'Filipino',
                groupValue: 'English',
                title: const Text('Filipino'),
                activeColor: AppColors.primary,
                onChanged: (_) {
                  Navigator.pop(context);

                  _showMessage(
                    'Filipino language will be available soon.',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // CLEAR DATA CONFIRMATION
  // ============================================================

  void _showClearConfirmation() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          icon: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.redLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.delete_outline,
              color: AppColors.red,
              size: 30,
            ),
          ),
          title: const Text(
            'Clear All Applications?',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'This will remove all saved job applications. '
            'This action cannot be undone.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textMedium,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);

                _showMessage(
                  'All applications have been cleared.',
                );
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // LOGOUT CONFIRMATION
  // ============================================================

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          icon: Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: AppColors.redLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.logout,
              color: AppColors.red,
              size: 28,
            ),
          ),
          title: const Text(
            'Logout?',
            textAlign: TextAlign.center,
          ),
          content: const Text(
            'Are you sure you want to logout?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textMedium,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);

                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/',
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.textDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
