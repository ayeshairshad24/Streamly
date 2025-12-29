import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/Services/auth.dart';
import '/Services/biometric_auth_service.dart';
import '/Services/consts.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final BiometricAuthService _biometricService = BiometricAuthService();
  bool _showBiometricButton = false;
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  /// Check if biometric auth is available and enabled
  Future<void> _checkBiometricAvailability() async {
    final shouldShow = await _biometricService.shouldShowBiometricOption();
    if (mounted) {
      setState(() {
        _showBiometricButton = shouldShow;
      });

      // Auto-trigger biometric if available
      if (shouldShow) {
        _authenticateWithBiometric();
      }
    }
  }

  /// Authenticate using biometrics
  Future<void> _authenticateWithBiometric() async {
    if (_isAuthenticating) return;

    setState(() {
      _isAuthenticating = true;
    });

    try {
      final authenticated = await _biometricService.authenticateWithBiometrics();

      if (authenticated && mounted) {
        final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
        final success = await provider.silentSignIn();

        if (!success && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Biometric authentication successful, but login failed. Please sign in with Google.'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Authentication error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isAuthenticating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: backgroundPrimary,
        child: SafeArea(
          child: Container(
            color: backgroundPrimary,
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: size.height * 0.3,
                ),
                Lottie.asset(
                  "assets/AuthDuck.json",
                  width: size.width * 0.60,
                  frameRate: const FrameRate(60),
                ),

                // Biometric login button
                if (_showBiometricButton)
                  Container(
                    margin: const EdgeInsets.fromLTRB(24, 16, 24, 8),
                    width: double.infinity,
                    height: 72,
                    child: ElevatedButton.icon(
                      onPressed: _isAuthenticating ? null : _authenticateWithBiometric,
                      icon: _isAuthenticating
                          ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Icon(
                        Icons.fingerprint,
                        color: Colors.white,
                        size: 32,
                      ),
                      label: Text(
                        _isAuthenticating ? "Authenticating..." : "Login with Fingerprint",
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: accentSecondary.withValues(alpha: 0.2),
                        side: BorderSide(color: accentSecondary, width: 1),
                      ),
                    ),
                  ),

                // Google Sign-In button
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(24, _showBiometricButton ? 8 : 24, 24, 0),
                    width: double.infinity,
                    height: 72,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false,
                        );
                        provider.googleLogin();
                      },
                      icon: const FaIcon(
                        FontAwesomeIcons.google,
                        color: Colors.white,
                      ),
                      label: Text(
                        signInText,
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: const Color(0xFF2A292F),
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: const EdgeInsets.fromLTRB(28, 16, 28, 24),
                  child: Text(
                    footerText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Color(0xFF423E50)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}