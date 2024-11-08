// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehaish_app/config/color_constants.dart';
import 'package:rehaish_app/screens/bookmarks_screen.dart';
import 'package:rehaish_app/screens/home_screen.dart';
import 'package:rehaish_app/screens/settings_screen.dart';
import 'package:rehaish_app/screens/profile_screen.dart';

import '../providers/auth_provider.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key});

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  int _selectedIndex = 0;

  // Define pages for logged-in and guest users
  static List<Widget> getPages(bool isLoggedIn) {
    if (isLoggedIn) {
      return const [
        HomeScreen(),
        BookmarksScreen(),
        SettingsScreen(),
        ProfileScreen(),
      ];
    } else {
      return const [
        HomeScreen(),
        SettingsScreen(),
        ProfileScreen(),
      ];
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = Provider.of<AuthProvider>(context).isLoggedIn();
    final pages = getPages(isLoggedIn);

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: isLoggedIn
            ? const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark), label: 'Bookmarks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ]
            : const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profile'),
              ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: ColorConstants.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
