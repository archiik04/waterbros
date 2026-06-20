import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;
  bool _showTermsError = false;

  // Real-time password criteria
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePasswordCriteria);
  }

  @override
  void dispose() {
    _passwordController.removeListener(_validatePasswordCriteria);
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validatePasswordCriteria() {
    final val = _passwordController.text;
    setState(() {
      _hasMinLength = val.length >= 8;
      _hasUppercase = val.contains(RegExp(r'[A-Z]'));
      _hasNumber = val.contains(RegExp(r'[0-9]'));
      _hasSpecialChar = val.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    });
  }

  void _submit() {
    setState(() {
      _showTermsError = !_acceptTerms;
    });

    if ((_formKey.currentState?.validate() ?? false) && _acceptTerms) {
      ref.read(authProvider.notifier).register(
            _nameController.text.trim(),
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Join WaterBros Today',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF111827),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Track hydration, complete weekly challenges, and compare rankings with friends.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Full Name Field
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name';
                        }
                        if (value.trim().length < 2) {
                          return 'Name must be at least 2 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                        if (!regex.hasMatch(value.trim())) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (!_hasMinLength || !_hasUppercase || !_hasNumber || !_hasSpecialChar) {
                          return 'Password must satisfy all criteria below';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 12),

                    // Password Criteria Indicator Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password Requirements:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: 12,
                              color: isDark ? const Color(0xFFF1F5F9) : const Color(0xFF1E293B),
                            ),
                          ),
                          const SizedBox(height: 6),
                          _buildCriteriaRow('Min 8 characters', _hasMinLength),
                          _buildCriteriaRow('At least 1 uppercase letter', _hasUppercase),
                          _buildCriteriaRow('At least 1 number', _hasNumber),
                          _buildCriteriaRow('At least 1 special character (!@#\$%^&*)', _hasSpecialChar),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Confirm Password Field
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: const Icon(Icons.lock_clock_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword = !_obscureConfirmPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Terms Box
                    CheckboxListTile(
                      value: _acceptTerms,
                      activeColor: isDark ? Colors.white : Colors.black,
                      checkColor: isDark ? Colors.black : Colors.white,
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _acceptTerms = val;
                            if (val) _showTermsError = false;
                          });
                        }
                      },
                      title: Text(
                        'I acknowledge the Terms of Service and Privacy Policy.',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? const Color(0xFFF1F5F9) : const Color(0xFF1E293B),
                        ),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding: EdgeInsets.zero,
                    ),
                    if (_showTermsError)
                      const Padding(
                        padding: EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          'You must acknowledge the terms to register',
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),

                    // Error states from provider
                    if (authState.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFEF4444)),
                          ),
                          child: Text(
                            authState.errorMessage!,
                            style: const TextStyle(color: Color(0xFF991B1B)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                    // Submit button
                    if (authState.status == AuthStatus.loading)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: CircularProgressIndicator(),
                        ),
                      )
                    else
                      ElevatedButton(
                        onPressed: _submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isDark ? Colors.white : Colors.black,
                          foregroundColor: isDark ? Colors.black : Colors.white,
                          shape: const StadiumBorder(),
                        ),
                        child: const Text(
                          'CREATE ACCOUNT',
                        ),
                      ),
                    const SizedBox(height: 32),

                    // Link back to Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.pop(),
                          style: TextButton.styleFrom(
                            foregroundColor: isDark ? Colors.white : Colors.black,
                          ),
                          child: const Text('Log In'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCriteriaRow(String text, bool met) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(
            met ? Icons.check_circle_rounded : Icons.radio_button_unchecked_rounded,
            size: 14,
            color: met ? const Color(0xFF10B981) : Colors.grey,
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              color: met ? const Color(0xFF10B981) : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
