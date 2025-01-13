import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/app/app_colors.dart';
import 'package:project/features/auth/ui/screens/forget_pass_phone_screen.dart';
import 'package:project/features/auth/ui/screens/phone_verification_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedRole;
  final List<String> _roles = ['Student', 'Teacher', 'Driver'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),

              const SizedBox(height: 16),
              Text('Sign In', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 24),
              buildForm(),
              ElevatedButton(
                onPressed: _onTapNextButton, //need to Fixed here withcorrect function
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 14),
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: _onTapForgetPasswordButton,
                      child: const Text(
                        'Forget your password?',
                        style: TextStyle(letterSpacing: 0.5, color: Colors.grey),
                      ),
                    ),
                    _buildSignUpSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTapForgetPasswordButton() {
    Get.to(() => const ForgetPassPhoneScreen());
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Dropdown for role selection (first field)
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(hintText: 'Select Role'),
            value: _selectedRole,
            items: _roles.map((role) {
              return DropdownMenuItem<String>(
                value: role,
                child: Text(role),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedRole = value;
              });
            },
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please select a role';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          if (_selectedRole != null) ...[
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _emailTEController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(hintText: 'Email'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter your email';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _passwordTEController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter your password';
                }
                if (value!.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }

  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
        text: "Don't have an account?  ",
        children: [
          TextSpan(
            text: 'Sign up ',
            style: const TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTapSignUp,
          ),
        ],
      ),
    );
  }

  void _onTapNextButton() {
    /*if (!_formKey.currentState!.validate()) {
      return;  // If form is invalid, do nothing
    }*/

  }


  void _onTapSignUp() {
    Get.to(() => const PhoneVerificationScreen());
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
