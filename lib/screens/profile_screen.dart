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
        backgroundColor: ColorConstants.primaryColor,
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
                      Text(
                        user.username,
                        style: TextStyles.appTitle.copyWith(
                          color: ColorConstants.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        user.email,
                        style: TextStyles.appCaption.copyWith(color: Colors.black),
                      ),
                      const SizedBox(height: 30),
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
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () async {
                          await authProvider.logout();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
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
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You are not logged in", style: TextStyles.appTitle),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(150, 50),
                    ),
                    child: const Text("Go to Login", style: TextStyles.buttonText),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyles.appCaption.copyWith(color: Colors.black)),
          Text(value, style: TextStyles.appCaption.copyWith(color: ColorConstants.secondaryColor)),
        ],
      ),
    );
  }
}
