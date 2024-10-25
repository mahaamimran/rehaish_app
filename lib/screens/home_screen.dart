import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dorms = [
      {'title': 'Temp Dorm with ImageCover', 'price': '38 PKR', 'city': 'Rawalpindi'},
      {'title': 'Another Test Dorm', 'price': '427 PKR', 'city': 'Rawalpindi'},
      {'title': 'Amazing House For Sale', 'price': '20,000 PKR', 'city': 'Islamabad'},
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: dorms.length,
        itemBuilder: (context, index) {
          final dorm = dorms[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              leading: const Icon(Icons.house),
              title: Text(dorm['title']),
              subtitle: Text('${dorm['city']}, Price: ${dorm['price']}'),
              trailing: const Text('PKR'),
            ),
          );
        },
      ),
    );
  }
}
