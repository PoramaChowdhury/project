import 'package:flutter/material.dart';
import 'package:project/features/auth/ui/widgets/app_logo_widget.dart';

class CompleteProfileScreen extends StatefulWidget {
  final String? phoneNumber;

  const CompleteProfileScreen({super.key, this.phoneNumber});

  static const String name = '/complete-profile';

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _firstNameTEController = TextEditingController();
  final TextEditingController _lastNameTEController = TextEditingController();
  final TextEditingController _mobileTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _selectedRole;
  final List<String> _roles = ['Student', 'Teacher', 'Driver'];

  @override
  void initState() {
    super.initState();

    // If the phone number is passed, set it in the mobile text controller
    if (widget.phoneNumber != null) {
      _mobileTEController.text = widget.phoneNumber!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),
              const AppLogoWidget(width: 100, height: 100),
              const SizedBox(height: 16),
              Text('Complete Profile',
                  style: Theme.of(context).textTheme.titleLarge),
              Text(
                'Get started with us with your profile',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 24),
              buildForm(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Perform the submit action
                  }
                },
                child: const Text('Complete'),
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
              controller: _firstNameTEController,
              decoration: const InputDecoration(hintText: 'First Name'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter your first name';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _lastNameTEController,
              decoration: const InputDecoration(hintText: 'Last Name'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter your last name';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _mobileTEController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(hintText: 'Mobile'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Enter your mobile number';
                }
                if (RegExp(r"^\+8801[3-9]\d{8}$").hasMatch(value!) == false) {
                  return 'Enter valid mobile number';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
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
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _confirmPasswordTEController,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Confirm Password'),
              validator: (String? value) {
                if (value?.trim().isEmpty ?? true) {
                  return 'Confirm your password';
                }
                if (value != _passwordTEController.text) {
                  return 'Passwords do not match';
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
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _mobileTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    _confirmPasswordTEController.dispose();
    super.dispose();
  }
}
