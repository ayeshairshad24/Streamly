import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '/Services/watch_list_screen.dart';
import '/Services/auth.dart';
import '/Services/biometric_auth_service.dart';
import '/Services/consts.dart';
import '/Widgets/bottom_nav_bar.dart';
import '/Widgets/loading_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ScrollController _scrollController;
  bool isVisible = true;
  bool isLoading = true;

  List watchlist = [];
  List completed = [];
  List watching = [];
  List onhold = [];
  List dropped = [];

  final User _user = FirebaseAuth.instance.currentUser!;
  final BiometricAuthService _biometricService = BiometricAuthService();

  bool _biometricAvailable = false;
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(listen);
    fetchData();
    _checkBiometricStatus();
  }

  @override
  void dispose() {
    _scrollController.removeListener(listen);
    _scrollController.dispose();
    super.dispose();
  }

  void listen() {
    final direction = _scrollController.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  /// Check biometric availability and enabled status
  Future<void> _checkBiometricStatus() async {
    final available = await _biometricService.isBiometricAvailable();
    final enabled = await _biometricService.isBiometricLoginEnabled();

    if (mounted) {
      setState(() {
        _biometricAvailable = available;
        _biometricEnabled = enabled;
      });
    }
  }

  /// Toggle biometric authentication
  Future<void> _toggleBiometric(bool value) async {
    if (value) {
      // Enable biometric
      final authenticated = await _biometricService.authenticateWithBiometrics();

      if (authenticated) {
        await _biometricService.enableBiometricLogin(_user.email!);
        if (mounted) {
          setState(() {
            _biometricEnabled = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Biometric login enabled successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Biometric authentication failed'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else {
      // Disable biometric
      await _biometricService.disableBiometricLogin();
      if (mounted) {
        setState(() {
          _biometricEnabled = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Biometric login disabled'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  void fetchData() async {
    List tempWatch = [];
    List tempComp = [];
    List tempHold = [];
    List tempDrop = [];

    final data = await FireBaseServices().getWatchList();

    for (var item in data) {
      if (item["status"] == "Completed") {
        tempComp.add(item);
      } else if (item["status"] == "Watching") {
        tempWatch.add(item);
      } else if (item["status"] == "On-Hold") {
        tempHold.add(item);
      } else if (item["status"] == "Dropped") {
        tempDrop.add(item);
      }
    }

    if (mounted) {
      setState(() {
        watchlist = data;
        completed = tempComp;
        watching = tempWatch;
        onhold = tempHold;
        dropped = tempDrop;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundPrimary,
      extendBody: true,
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        height: isVisible ? 75 : 0,
        child: const Wrap(
          children: [
            BottomNavBar(currentIndex: 2),
          ],
        ),
      ),
      body: isLoading
          ? const LoadingScreen()
          : ListView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          headerSection(context),

          // Biometric toggle section
          if (_biometricAvailable)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: const Color(0xFF14303B).withValues(alpha: 0.25),
                border: Border.all(
                  color: const Color(0xFF14303B).withValues(alpha: 0.5),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.fingerprint, color: accentSecondary, size: 32),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Biometric Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Use fingerprint to login',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Switch(
                    value: _biometricEnabled,
                    onChanged: _toggleBiometric,
                    activeColor: accentSecondary,
                  ),
                ],
              ),
            ),

          statsGrid(context),
        ],
      ),
    );
  }

  Widget headerSection(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
          height: 300,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(_user.photoURL ?? ''),
              fit: BoxFit.cover,
            ),
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: Container(color: Colors.black.withValues(alpha: 0.2)),
            ),
          ),
        ),
        Container(
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.center,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                backgroundPrimary.withValues(alpha: 0.5),
                backgroundPrimary,
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(_user.photoURL ?? ''),
              ),
              const SizedBox(height: 10),
              Text(
                _user.displayName ?? 'User Name',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Positioned(
          top: 50,
          right: 20,
          child: IconButton(
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
            onPressed: () {
              final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
              context.pushReplacement('/');
            },
          ),
        ),
      ],
    );
  }

  Widget statsGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _navigate(watching, "Watching"),
                child: watchListTile(watching.length.toString(), "Watching"),
              ),
              GestureDetector(
                onTap: () => _navigate(completed, "Completed"),
                child: watchListTile(completed.length.toString(), "Completed"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () => _navigate(onhold, "On Hold"),
                child: watchListTile(onhold.length.toString(), "On Hold"),
              ),
              GestureDetector(
                onTap: () => _navigate(dropped, "Dropped"),
                child: watchListTile(dropped.length.toString(), "Dropped"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigate(List list, String status) {
    if (list.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              WatchListScreen(watchList: list, status: status),
        ),
      );
    }
  }
}

Widget watchListTile(String count, String title) {
  return Container(
    height: 110,
    width: 160,
    margin: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: const Color(0xFF14303B).withValues(alpha: 0.25),
      border: Border.all(
          color: const Color(0xFF14303B).withValues(alpha: 0.5), width: 1),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(count,
              style: TextStyle(
                  color: accentSecondary,
                  fontSize: 32,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(title,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    ),
  );
}