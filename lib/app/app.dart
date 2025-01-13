import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/app/app_theme_data.dart';
import 'package:project/app/controler_binder.dart';
import 'package:project/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:project/features/auth/ui/screens/forget_pass_otp_screen.dart';
import 'package:project/features/auth/ui/screens/forget_pass_phone_screen.dart';
import 'package:project/features/auth/ui/screens/otp_verification_screen.dart';
import 'package:project/features/auth/ui/screens/phone_verification_screen.dart';
import 'package:project/features/auth/ui/screens/sign_in_screen.dart';
import 'package:project/features/auth/ui/screens/splash_screen.dart';

class Project extends StatefulWidget {
  const Project({super.key});

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        initialRoute: '/',
        theme: AppThemeData.lightThemeData,
        darkTheme: AppThemeData.darkThemeData,
        themeMode: ThemeMode.system,
        initialBinding: ControllerBinder(),
        onGenerateRoute: (RouteSettings settings) {
          late Widget widget;
          if (settings.name == SplashScreen.name) {
            widget = const SplashScreen();
          } else if (settings.name == PhoneVerificationScreen.name) {
            widget = const PhoneVerificationScreen();
          } else if (settings.name == OtpVerificationScreen.name) {
            widget = const OtpVerificationScreen();
          } else if (settings.name == CompleteProfileScreen.name) {
            String phoneNumber = settings.arguments as String;
            widget =  CompleteProfileScreen(phoneNumber: phoneNumber);
          }else if (settings.name == SignInScreen.name) {
            widget = const SignInScreen();
          }else if (settings.name == ForgetPassPhoneScreen.name) {
            widget = const ForgetPassPhoneScreen();
          }else if (settings.name == ForgetPassOtpScreen.name) {
            widget = const ForgetPassOtpScreen();
          }

          return MaterialPageRoute(builder: (ctx) {
            return widget;
          });
        });
  }
}
