import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehaish_app/widgets/dorm_card.dart';
import '../providers/dorm_provider.dart';
import '../config/color_constants.dart';
import '../config/text_styles.dart';
import '../config/enums.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dormProvider = Provider.of<DormProvider>(context);

    // Check if dorms are already loaded, otherwise fetch them
    if (dormProvider.dataStatus == DataStatus.initial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        dormProvider.fetchDorms();
      });
    }

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Rehaish Ki Khwaish',
          style: TextStyles.appBarTitle,
        ),
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: Builder(
        builder: (context) {
          switch (dormProvider.dataStatus) {
            case DataStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case DataStatus.loaded:
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ListView.builder(
                  itemCount: dormProvider.dorms.length,
                  itemBuilder: (context, index) {
                    final dorm = dormProvider.dorms[index];
                    return DormCard(dorm: dorm);
                  },
                ),
              );
            case DataStatus.failure:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red, size: 60),
                    const SizedBox(height: 10),
                    const Text(
                      'Failed to load dorms. Please try again later.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        dormProvider.fetchDorms(); // Retry fetching dorms
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            default:
              return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}
