import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:rehaish_app/providers/auth_provider.dart';
import 'package:rehaish_app/config/color_constants.dart';
import 'package:rehaish_app/config/text_styles.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _usernameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('SignupScreen', style: TextStyles.appBarTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person, size: 50, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            ToggleButtons(
              isSelected: const [false, true],
              selectedColor: Colors.white,
              fillColor: ColorConstants.primaryColor,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text("Log In", style: TextStyles.buttonText),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text("Sign Up", style: TextStyles.buttonText),
                ),
              ],
              onPressed: (index) {
                if (index == 0) {
                  Navigator.pushNamed(context, '/login');
                }
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "Username",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: "First Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: "Last Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              // onPressed: () => authProvider.signupUser(
              //   _usernameController.text,
              //   _firstNameController.text,
              //   _lastNameController.text,
              //   _emailController.text,
              //   _passwordController.text,
              //   _confirmPasswordController.text,
              // ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primaryColor,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text("Sign Up", style: TextStyles.buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
