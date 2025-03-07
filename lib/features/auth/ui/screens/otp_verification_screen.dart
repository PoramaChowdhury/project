import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:project/app/app_colors.dart';
import 'package:project/app/app_constants.dart';
import 'package:project/features/auth/ui/screens/complete_profile_screen.dart';
import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  static const String name = '/otp-verification';

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RxInt _remainingTime = AppConstants.resendOtpTimeOutInSecs.obs;
  late Timer timer;
  final RxBool _enableResendCodeButton = false.obs;

  @override
  void initState() {
    super.initState();
    _startResendCodeTimer();
  }

  void _startResendCodeTimer() {
    _enableResendCodeButton.value = false;
    _remainingTime.value = AppConstants.resendOtpTimeOutInSecs;
    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      _remainingTime.value--;
      if (_remainingTime.value == 0) {
        t.cancel();
        _enableResendCodeButton.value = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 80),
                const AppLogoWidget(),
                const SizedBox(height: 16),
                Text(
                  'Enter OTP Code',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'A 4 Digit OTP Code has been Sent',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 24),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 300),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    activeColor: AppColors.themeColor,
                    inactiveColor: AppColors.themeColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor:
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey
                      : Colors.white,
                  keyboardType: TextInputType.number,
                  appContext: context,
                  controller: _otpTEController,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CompleteProfileScreen.name);
                  },
                  child: const Text('Next'),
                ),
                const SizedBox(height: 16),
                Obx(
                      () => Visibility(
                    visible: !_enableResendCodeButton.value,
                    child: RichText(
                      text: TextSpan(
                          text: 'This code will be expire in ',
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(
                                text: '${_remainingTime}s',
                                style: const TextStyle(
                                  color: AppColors.themeColor,
                                ))
                          ]),
                    ),
                  ),
                ),
                Obx(
                      () => Visibility(
                    visible: _enableResendCodeButton.value,
                    child: TextButton(
                      onPressed: () {
                        _startResendCodeTimer();
                      },
                      child: const Text('Resend Code'),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}