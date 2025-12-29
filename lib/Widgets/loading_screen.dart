import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/Services/consts.dart';

/// I show a full-screen loading animation while the app waits for data.
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: backgroundPrimary,
      child: Center(
        child: Lottie.asset(
          "assets/LoadingDuck.json",
          width: size.width * 0.5,
          frameRate: const FrameRate(60),
        ),
      ),
    );
  }
}
