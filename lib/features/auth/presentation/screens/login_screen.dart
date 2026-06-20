import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:waterbros/features/onboarding/presentation/screens/welcome_screen.dart';
import '../providers/auth_provider.dart';
import '../widgets/social_auth_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authProvider.notifier).login(
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Brand Logo Section (Cute droplet illustration matching welcome screen)
                    const SizedBox(height: 16),
                    Center(
                      child: SizedBox(
                        width: 100,
                        height: 120,
                        child: CustomPaint(
                          painter: DropletPainter(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'WaterBros',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                            color: isDark ? Colors.white : const Color(0xFF111827),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Compete. Stay Hydrated. Win.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    
                    // Welcome Header
                    Text(
                      'Welcome Back',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: isDark ? Colors.white : const Color(0xFF111827),
                          ),
                    ),
                    const SizedBox(height: 24),

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
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),

                    // Forgot Password link
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => context.push('/forgot-password'),
                        style: TextButton.styleFrom(
                          foregroundColor: isDark ? const Color(0xFF94A3B8) : const Color(0xFF4B5563),
                        ),
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Error message state
                    if (authState.errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEE2E2), // Light red bg
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

                    // Login button
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
                          'LOG IN',
                        ),
                      ),
                    const SizedBox(height: 24),

                    // Or Divider
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Or continue with',
                            style: TextStyle(
                              color: isDark ? const Color(0xFF64748B) : const Color(0xFF9CA3AF),
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Social buttons
                    SocialAuthButton(
                      label: 'Continue with Google',
                      provider: 'google',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Google Sign-In Triggered (Mock)')),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    SocialAuthButton(
                      label: 'Continue with Apple',
                      provider: 'apple',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Apple Sign-In Triggered (Mock)')),
                        );
                      },
                    ),
                    const SizedBox(height: 32),

                    // Link to Signup
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                        ),
                        TextButton(
                          onPressed: () => context.push('/signup'),
                          style: TextButton.styleFrom(
                            foregroundColor: isDark ? Colors.white : Colors.black,
                          ),
                          child: const Text('Sign Up'),
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
}
