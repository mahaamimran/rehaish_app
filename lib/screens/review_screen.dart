import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehaish_app/providers/auth_provider.dart';
import 'package:rehaish_app/providers/review_provider.dart';
import 'package:rehaish_app/config/color_constants.dart';
import 'package:rehaish_app/config/text_styles.dart';
import 'package:rehaish_app/widgets/custom_alert_dialog.dart';

class ReviewScreen extends StatefulWidget {
  final String dormId;

  const ReviewScreen({super.key, required this.dormId});

  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final TextEditingController _reviewTitleController = TextEditingController();
  final TextEditingController _reviewTextController = TextEditingController();
  double _rating = 5.0;

void _submitReview() async {
  final authProvider = Provider.of<AuthProvider>(context, listen: false);
  final reviewProvider = Provider.of<ReviewProvider>(context, listen: false);

  if (!authProvider.isLoggedIn()) {
    // Show login dialog if the user is not logged in
    showDialog(
      context: context,
      builder: (ctx) => CustomAlertDialog(
        title: "Not Logged In",
        content: "Please log in to submit a review.",
        cancelButtonText: "Cancel",
        confirmButtonText: "Log In",
        onConfirm: () {
          Navigator.of(context).pushReplacementNamed('/login');
        },
      ),
    );
    return;
  }

  try {
    await reviewProvider.addReview(
      widget.dormId,
      _reviewTitleController.text.isNotEmpty ? _reviewTitleController.text : "Untitled Review",
      _reviewTextController.text.isNotEmpty ? _reviewTextController.text : "No content provided",
      _rating,
      authProvider.currentUser!.id, // Ensure this is non-null
      context,
    );

    // Show success dialog on successful submission
    showDialog(
      context: context,
      builder: (ctx) => CustomAlertDialog(
        title: "Success",
        content: "Your review has been submitted successfully!",
        cancelButtonText: "",
        confirmButtonText: "OK",
        onConfirm: () {
          Navigator.of(context).pop(); // Close dialog
          Navigator.of(context).pop(); // Go back to the previous screen
        },
      ),
    );
  } catch (error) {
    // Show error dialog if there's an issue
    showDialog(
      context: context,
      builder: (ctx) => CustomAlertDialog(
        title: "Error",
        content: "Failed to submit review. Please try again later.",
        cancelButtonText: "OK",
        confirmButtonText: "",
        onConfirm: () => Navigator.of(context).pop(),
      ),
    );
  }
}

  Widget _buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return IconButton(
          icon: Icon(
            index < _rating ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1.0;
            });
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Review", style: TextStyles.appBarTitle),
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _reviewTitleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _reviewTextController,
              decoration: const InputDecoration(labelText: "Review"),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            const Text("Rating"),
            _buildStarRating(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Submit", style: TextStyles.buttonText),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
