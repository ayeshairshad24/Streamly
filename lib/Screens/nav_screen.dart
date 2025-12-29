import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/Screens/main_screen.dart';
import '/Screens/login_screen.dart';
// import '/Screens/profile_screen.dart';
// import '/Screens/search_screen.dart';
// import '/Widgets/bottom_nav_bar.dart';

class NavScreen extends StatefulWidget with RouteAware {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  @override

  /// Student Note:
  /// Listens to `FirebaseAuth.authStateChanges()` to determine if the user is
  /// logged in. If yes, shows `MainScreen`; otherwise shows `LoginScreen`.
  /// This decouples authentication status from the UI navigation.
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return snapshot.hasData ? const MainScreen() : const LoginScreen();
        },
      ),
    );
  }
}
