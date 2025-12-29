import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/Services/consts.dart';

/// I show a friendly error animation when something goes wrong loading data.
class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: backgroundPrimary,
      body: Center(
        child: Lottie.asset(
          "assets/ErrorDuck.json",
          width: size.width * 0.5,
          frameRate: const FrameRate(60),
        ),
      ),
    );
  }
}
