import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehaish_app/providers/user_provider.dart';
import 'package:rehaish_app/providers/dorm_provider.dart';
import 'package:rehaish_app/widgets/dorm_card.dart';
import '../config/color_constants.dart';
import '../config/text_styles.dart';

class BookmarksScreen extends StatelessWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final dormProvider = Provider.of<DormProvider>(context);

    final bookmarkedDorms = dormProvider.getDormsByIds(userProvider.bookmarkedDormIds);

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
