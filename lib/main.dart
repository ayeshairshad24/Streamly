import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Services/auth.dart';
import 'routes.dart';
import 'package:provider/provider.dart';

/// I initialize Flutter bindings and Firebase, then start the app.
/// This ensures Firebase and Flutter are ready before I use them elsewhere.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  /// I build the root widget tree and register providers and routes.
  /// This lets me access authentication providers across the app.
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
      ),
    );
  }
}
//Bhatti
//