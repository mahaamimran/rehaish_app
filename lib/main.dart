import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehaish_app/providers/dorm_provider.dart';
import 'package:rehaish_app/providers/settings_provider.dart';
import 'package:rehaish_app/providers/auth_provider.dart';
import 'package:rehaish_app/providers/user_provider.dart';
import 'package:rehaish_app/screens/login_screen.dart';
import 'package:rehaish_app/screens/signup_screen.dart';
import 'package:rehaish_app/screens/tab_bar_screen.dart';
import 'package:rehaish_app/screens/settings_screen.dart';
import 'package:rehaish_app/screens/dorm_details_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DormProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      title: 'Rehaish ki Khwaish',
      debugShowCheckedModeBanner: false,
      home: authProvider.isLoggedIn() ? const TabBarScreen() : const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/tabBar': (context) => const TabBarScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/dormDetails') {
          final dormId = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => DormDetailsScreen(dormId: dormId),
          );
        }
        return null;
      },
    );
  }
}
