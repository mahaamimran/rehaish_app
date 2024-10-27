import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehaish_app/providers/auth_provider.dart';
import 'package:rehaish_app/providers/dorm_provider.dart';
import 'package:rehaish_app/widgets/dorm_card.dart';
import 'package:rehaish_app/screens/login_screen.dart';
import '../config/color_constants.dart';
import '../config/text_styles.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final dormProvider = Provider.of<DormProvider>(context);

    // Check if the user is logged in
    if (!authProvider.isLoggedIn()) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign in to view your bookmarks',
              style: TextStyles.appTitle,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstants.primaryColor,
              ),
              child: const Text('Sign In', style: TextStyles.buttonText),
            ),
          ],
        ),
      );
    }

    // Get bookmarked dorms
    final bookmarkedDorms = dormProvider.getDormsByIds(authProvider.currentUser!.bookmarks);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks', style: TextStyles.appBarTitle),
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: bookmarkedDorms.isEmpty
          ? const Center(
              child: Text(
                'No bookmarks yet.',
                style: TextStyles.appCaption,
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: bookmarkedDorms.length,
                itemBuilder: (context, index) {
                  final dorm = bookmarkedDorms[index];
                  return DormCard(dorm: dorm);
                },
              ),
            ),
    );
  }
}
