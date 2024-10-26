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
        centerTitle: true,
      ),
      body: user != null
          ? Container(
              color: ColorConstants.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
                child: Column(
                  children: [
                    // Profile Picture and Username Card
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: ColorConstants.secondaryColor.withOpacity(0.1),
                              child: const Icon(Icons.person, size: 50, color: ColorConstants.secondaryColor),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              user.username,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.primaryColor,
                              ),
                            ),
                            Text(
                              user.email,
                              style: const TextStyle(
                                fontSize: 16,
                                color: ColorConstants.subtitleColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // User Information Section
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow("First Name:", user.firstName),
                            const Divider(),
                            _buildInfoRow("Last Name:", user.lastName),
                            const Divider(),
                            _buildInfoRow("Role:", user.role),
                            const Divider(),
                            _buildInfoRow("Account Created:", user.createdAt.split('T')[0]),
                          ],
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Logout Button
                    ElevatedButton(
                      onPressed: () async {
                        await authProvider.logout();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.accentColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        "Log Out",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  // Helper method to build each row of user information
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: ColorConstants.textColor,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: ColorConstants.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
