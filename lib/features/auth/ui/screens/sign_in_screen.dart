import 'package:flutter/material.dart';

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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Handle the sign-in process
                  }
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
    );
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

          // Only show the email and password fields if a role is selected
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

                if (_selectedRole == 'Student') {
                  if (!RegExp(r'^cse_\d{15}@lus\.ac\.bd$').hasMatch(value!)) {
                    return 'Enter a valid student email';
                  }
                } else if (_selectedRole == 'Teacher') {
                  if (!RegExp(r'^[a-zA-Z]+_cse@lus\.ac\.bd$')
                      .hasMatch(value!)) {
                    return 'Enter a valid teacher email';
                  }
                } else if (_selectedRole == 'Driver') {
                  if (!RegExp(r'^[a-zA-Z]+_driver@lus\.ac\.bd$')
                      .hasMatch(value!)) {
                    return 'Enter a valid driver email';
                  }
                } else {
                  return 'Please select a role first';
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

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
