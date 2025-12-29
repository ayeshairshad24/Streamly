import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter/services.dart';
import 'package:streamly/Services/consts.dart';

/// I display the bottom navigation bar and handle navigation taps to main/search/profile.
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key, required this.currentIndex}) : super(key: key);
  final int currentIndex;

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.fromLTRB(8, 8, 8, 16),
      decoration: BoxDecoration(
          color: accentT.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.home_rounded,
              color:
                  widget.currentIndex == 0 ? accentSecondary : inactiveAccent,
            ),
            onPressed: () {
              HapticFeedback.mediumImpact();
              GoRouter.of(context).go('/main');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              color:
                  widget.currentIndex == 1 ? accentSecondary : inactiveAccent,
            ),
            onPressed: () {
              HapticFeedback.mediumImpact();
              GoRouter.of(context).go('/search');
            },
          ),
          IconButton(
            icon: Icon(
              UniconsLine.heart,
              color: widget.currentIndex == 2 ? Colors.white : inactiveAccent,
            ),
            onPressed: () {
              HapticFeedback.mediumImpact();
              GoRouter.of(context).go('/profile');
            },
          ),
        ],
      ),
    );
  }
}
