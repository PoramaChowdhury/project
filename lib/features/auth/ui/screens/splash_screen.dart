import 'package:flutter/material.dart';
import 'package:project/features/auth/ui/screens/phone_verification_screen.dart';
import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';

class SplashScreen extends StatefulWidget {
  static const String name = '/';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacementNamed(context, PhoneVerificationScreen.name);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              AppLogoWidget(),
              Spacer(),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
