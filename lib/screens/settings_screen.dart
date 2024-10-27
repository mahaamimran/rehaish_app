import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehaish_app/providers/auth_provider.dart';
import 'package:rehaish_app/screens/login_screen.dart';
import 'package:rehaish_app/screens/profile_screen.dart';
import 'package:rehaish_app/config/color_constants.dart';
import 'package:rehaish_app/config/text_styles.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false; // Assuming you have a dark mode toggle
  bool _notificationsEnabled = true; // Notifications toggle

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyles.appBarTitle,
        ),
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Account Section
          const Text('Account', style: TextStyles.appTitle),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.person_crop_circle),
            title: GestureDetector(
              onTap: authProvider.isLoggedIn()
                  ? () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => const ProfileScreen()),
                      );
                    }
                  : null,
              child: Text(
                authProvider.isLoggedIn()
                    ? 'Logged in as: ${authProvider.currentUser?.username}'
                    : 'Not logged in',
                style: TextStyles.caption(context).copyWith(color: Colors.black),
              ),
            ),
            subtitle: authProvider.isLoggedIn()
                ? Text('Manage your account details', style: TextStyles.caption(context).copyWith(color: Colors.black))
                : null,
          ),

          const SizedBox(height: 20),

          // Appearance Section
          const Text('Appearance', style: TextStyles.appTitle),
          const Divider(),
          CupertinoSwitchTile(
            title: 'Dark Mode',
            value: _darkMode,
            onChanged: (bool value) {
              setState(() {
                _darkMode = value;
              });
              // Add functionality to apply dark mode if applicable in your app
            },
          ),

          const SizedBox(height: 20),

          // Notifications Section
          const Text('Notifications', style: TextStyles.appTitle),
          const Divider(),
          CupertinoSwitchTile(
            title: 'Enable Notifications',
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
              // Add functionality to manage notifications
            },
          ),

          const SizedBox(height: 20),

          // Privacy Section
          const Text('Privacy & Security', style: TextStyles.appTitle),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.lock),
            title: Text('Privacy Policy', style: TextStyles.caption(context).copyWith(color: Colors.black)),
            onTap: () {
              // Open Privacy Policy page
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.doc_text),
            title: Text('Terms & Conditions', style: TextStyles.caption(context).copyWith(color: Colors.black)),
            onTap: () {
              // Open Terms & Conditions page
            },
          ),

          const SizedBox(height: 20),

          // Support Section
          const Text('Support', style: TextStyles.appTitle),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.question_circle),
            title: Text('Help Center', style: TextStyles.caption(context).copyWith(color: Colors.black)),
            onTap: () {
              // Open Help Center page
            },
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.mail),
            title: Text('Send Feedback', style: TextStyles.caption(context).copyWith(color: Colors.black)),
            onTap: () {
              // Open Feedback form or page
            },
          ),

          const SizedBox(height: 20),

          // About Us Section
          const Text('About Us', style: TextStyles.appTitle),
          const Divider(),
          ListTile(
            leading: const Icon(CupertinoIcons.info),
            title: Text('About us', style: TextStyles.caption(context).copyWith(color: Colors.black)),
            onTap: () {},
          ),

          const SizedBox(height: 40),

          // Logout Button
          if (authProvider.isLoggedIn())
            ListTile(
              leading: const Icon(CupertinoIcons.square_arrow_right, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                authProvider.logout();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('You have been logged out')),
                );
                Navigator.of(context).pushReplacement(
                  CupertinoPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
        ],
      ),
    );
  }
}

// A custom Cupertino-styled switch tile to align with the rest of the theme.
class CupertinoSwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CupertinoSwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyles.caption(context).copyWith(color: Colors.black)),
          CupertinoSwitch(
            focusColor: ColorConstants.primaryColor,
            activeColor: ColorConstants.primaryColor,
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
