import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehaish_app/providers/auth_provider.dart';
import 'package:rehaish_app/screens/login_screen.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display login status
            Text(
              authProvider.isLoggedIn()
                  ? 'You are logged in'
                  : 'You are not logged in',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            // Show Logout button if logged in
            if (authProvider.isLoggedIn())
              ElevatedButton(
                onPressed: () {
                  authProvider.logout();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('You have been logged out')),
                  );
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                child: const Text('Logout'),
              ),
          ],
        ),
      ),
    );
  }
}
