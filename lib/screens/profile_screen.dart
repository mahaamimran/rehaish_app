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
        backgroundColor: Colors.grey[800],
        centerTitle: true,
      ),
      body: user != null
          ? Container(
              color: ColorConstants.backgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 30.0),
                child: Column(
                  children: [
                    // Profile Picture and Username Card
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: ColorConstants.secondaryColor
                                  .withOpacity(0.1),
                              child: const Icon(Icons.person,
                                  size: 50,
                                  color: ColorConstants.secondaryColor),
                            ),
                            const SizedBox(height: 15),
                            Text(
                              user.username,
                              style: TextStyles.heading(context)
                                  .copyWith(color: ColorConstants.primaryColor),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              user.email,
                              style: TextStyles.appCaption,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),

                    // User Information Section
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(
                                "First Name:", user.firstName, context),
                            const Divider(),
                            _buildInfoRow("Last Name:", user.lastName, context),
                            const Divider(),
                            _buildInfoRow("Role:", user.role, context),
                            const Divider(),
                            _buildInfoRow("Account Created:",
                                user.createdAt.split('T')[0], context),
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
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child:
                          const Text("Log Out", style: TextStyles.buttonText),
                    ),
                  ],
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
            style: TextStyles.caption(context)
                .copyWith(color: ColorConstants.secondaryColor),
          ),
        ],
      ),
    );
  }
}
