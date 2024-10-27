import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehaish_app/providers/auth_provider.dart';
import 'package:rehaish_app/providers/dorm_provider.dart';
import 'package:rehaish_app/config/color_constants.dart';
import 'package:rehaish_app/config/text_styles.dart';
import 'package:rehaish_app/providers/user_provider.dart';
import 'package:rehaish_app/screens/login_screen.dart';
import 'package:rehaish_app/widgets/custom_alert_dialog.dart';

class DormDetailsScreen extends StatefulWidget {
  final String dormId;

  const DormDetailsScreen({super.key, required this.dormId});

  @override
  _DormDetailsScreenState createState() => _DormDetailsScreenState();
}

class _DormDetailsScreenState extends State<DormDetailsScreen> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final dormProvider = Provider.of<DormProvider>(context, listen: false);

      dormProvider.fetchDormById(widget.dormId);
      setState(() {
        isBookmarked = userProvider.isBookmarked(widget.dormId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final dormProvider = Provider.of<DormProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final dorm = dormProvider.currentDorm;

    if (dorm == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Dorm Details', style: TextStyles.appBarTitle),
          backgroundColor: ColorConstants.primaryColor,
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        title: const Text('Dorm Details', style: TextStyles.appBarTitle),
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
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(child: Text('Image Placeholder')),
            ),
            const SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(dorm.title, style: TextStyles.title(context)),
                    const SizedBox(height: 5),
                    Text(
                      '${dorm.address.city.name}, ${dorm.address.street}, ${dorm.address.province}, ${dorm.address.country}',
                      style: TextStyles.caption(context).copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contacting owner...')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Contact Owner', style: TextStyles.buttonText),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (!authProvider.isLoggedIn()) {
                        showDialog(
                          context: context,
                          builder: (ctx) => CustomAlertDialog(
                            title: "Not Logged In",
                            content: "You need to log in to bookmark.",
                            cancelButtonText: "Cancel",
                            confirmButtonText: "Log In",
                            onConfirm: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (context) => const LoginScreen()),
                                (route) => false,
                              );
                            },
                          ),
                        );
                        return;
                      }

                      setState(() {
                        isBookmarked = !isBookmarked;
                      });

                      if (isBookmarked) {
                        userProvider.addBookmark(dorm.id);
                      } else {
                        userProvider.removeBookmark(dorm.id);
                      }
                    },
                    icon: Icon(
                      isBookmarked ? Icons.check : Icons.bookmark_border,
                      color: Colors.white,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isBookmarked ? Colors.green : ColorConstants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    label: Text(
                      isBookmarked ? 'Bookmarked' : 'Bookmark',
                      style: TextStyles.caption(context).copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
