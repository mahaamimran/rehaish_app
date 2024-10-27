import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehaish_app/providers/auth_provider.dart';
import 'package:rehaish_app/screens/login_screen.dart';
import 'package:rehaish_app/config/color_constants.dart';
import 'package:rehaish_app/config/text_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyles.appBarTitle),
        backgroundColor: ColorConstants.primaryColor, // Set to primary color
        centerTitle: true,
        elevation: 0,
      ),
      body: user != null
          ? SingleChildScrollView(
              child: Container(
                color: ColorConstants.backgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: ColorConstants.primaryColor.withOpacity(0.1),
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: ColorConstants.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Username and Email
                      Text(
                        user.username,
                        style: TextStyles.heading(context).copyWith(
                          color: ColorConstants.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user.email,
                        style: TextStyles.caption(context).copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 30),

                      // User Information Section
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoRow("First Name:", user.firstName, context),
                              const Divider(),
                              _buildInfoRow("Last Name:", user.lastName, context),
                              const Divider(),
                              _buildInfoRow("Role:", user.role, context),
                              const Divider(),
                              _buildInfoRow("Account Created:", user.createdAt.split('T')[0], context),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Logout Button
                      ElevatedButton(
                        onPressed: () async {
                          await authProvider.logout();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorConstants.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text("Log Out", style: TextStyles.buttonText),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  // Helper method to build each row of user information
  Widget _buildInfoRow(String label, String value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyles.bold(context),
          ),
          Text(
            value,
            style: TextStyles.caption(context).copyWith(
              color: ColorConstants.secondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
