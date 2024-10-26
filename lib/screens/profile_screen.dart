import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehaish_app/providers/auth_provider.dart';
import 'package:rehaish_app/screens/login_screen.dart';
import 'package:rehaish_app/config/color_constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, size: 50, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              user?.username ?? 'Username',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              user?.email ?? 'Email Address',
              style: const TextStyle(fontSize: 16, color: ColorConstants.subtitleColor),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authProvider.logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primaryColor,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Log Out", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
