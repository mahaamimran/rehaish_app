import 'package:flutter/material.dart';
import 'package:rehaish_app/models/review.dart';
import 'package:rehaish_app/config/color_constants.dart';
import 'package:rehaish_app/config/text_styles.dart';

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture
            const ClipOval(
              child: Icon(
                Icons.person,
                size: 20,
                color: ColorConstants.primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            // Review Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review.title, style: TextStyles.title(context)),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Rating: ${review.rating}', style: TextStyles.caption(context)),
                      const SizedBox(width: 5),
                      const Icon(Icons.star, color: ColorConstants.accentColor, size: 16),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(review.text, style: TextStyles.appCaption),
                  const SizedBox(height: 5),
                  Text(
                    '- ${review.user.firstName} ${review.user.lastName}',
                    style: TextStyles.caption(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
