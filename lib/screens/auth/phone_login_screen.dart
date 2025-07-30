import 'package:flutter/material.dart';
import 'otp_verification_screen.dart';
import '../../theme/app_theme.dart';
import 'dart:ui';
import 'package:flutter/services.dart';

class PhoneLoginScreen extends StatefulWidget {
  final ValueChanged<String> onSendOtp;
  const PhoneLoginScreen({Key? key, required this.onSendOtp}) : super(key: key);

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String _formatPhoneNumber(String input) {
    // Format as 99999 99999
    final digits = input.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= 5) return digits;
    return digits.substring(0, 5) + ' ' + digits.substring(5, digits.length);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;
    bool isValidPhone = _phoneController.text.length == 10;

    return Scaffold(
      body: Stack(
        children: [
          // Animated gradient background
          Positioned.fill(
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.8, end: 1),
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              builder: (context, value, child) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primary.withOpacity(0.18 * value),
                      colorScheme.secondary.withOpacity(0.12 * value),
                      colorScheme.primary.withOpacity(0.10 * value),
                    ],
                  ),
                ),
                child: child,
              ),
              child: Stack(
                children: [
                  // Blurred animated bubble (top-left)
                  Positioned(
                    top: -size.width * 0.2,
                    left: -size.width * 0.2,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      width: size.width * 0.6,
                      height: size.width * 0.6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.primary.withOpacity(0.12),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.primary.withOpacity(0.10),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Blurred animated bubble (bottom-right)
                  Positioned(
                    bottom: -size.width * 0.18,
                    right: -size.width * 0.18,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      width: size.width * 0.45,
                      height: size.width * 0.45,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.secondary.withOpacity(0.10),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.secondary.withOpacity(0.10),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Animated logo with bounce
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0.7, end: 1),
                    duration: const Duration(milliseconds: 900),
                    curve: Curves.elasticOut,
                    builder: (context, value, child) => Transform.scale(
                      scale: value,
                      child: child,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: colorScheme.primary.withOpacity(0.12),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/images/logo.png',
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          semanticLabel: 'App Logo',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // Glassmorphism card
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.65),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colorScheme.primary.withOpacity(0.08)),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.primary.withOpacity(0.10),
                              blurRadius: 24,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Sign in to Continue',
                                style: textTheme.titleLarge?.copyWith(
                                  fontSize: 22,
                                  color: colorScheme.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Enter mobile number to receive an OTP',
                                style: textTheme.bodyMedium?.copyWith(
                                  fontSize: 15,
                                  color: Colors.grey[700],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              Form(
                                key: _formKey,
                                child: StatefulBuilder(
                                  builder: (context, setState) => TextFormField(
                                    controller: _phoneController,
                                    keyboardType: TextInputType.phone,
                                    style: textTheme.bodyLarge?.copyWith(fontSize: 18),
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      labelText: 'Mobile Number',
                                      labelStyle: textTheme.bodyMedium,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.only(left: 12, right: 8),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Indian flag emoji
                                            const Text('🇮🇳', style: TextStyle(fontSize: 18)),
                                            const SizedBox(width: 4),
                                            Text(
                                              '+91',
                                              style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(width: 4),
                                            Container(
                                              width: 1,
                                              height: 24,
                                              color: Colors.grey[300],
                                            ),
                                          ],
                                        ),
                                      ),
                                      prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(color: colorScheme.primary, width: 2),
                                      ),
                                      helperText: 'We will send you a one-time password (OTP)',
                                      suffixIcon: _phoneController.text.length == 10
                                        ? Icon(Icons.check_circle, color: colorScheme.primary)
                                        : null,
                                    ),
                                    inputFormatters: [
                                      // Only allow digits
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    validator: (value) {
                                      final digits = value?.replaceAll(RegExp(r'\D'), '');
                                      if (digits == null || digits.isEmpty) {
                                        return 'Please enter your mobile number';
                                      }
                                      if (digits.length != 10) {
                                        return 'Enter a valid 10-digit number';
                                      }
                                      return null;
                                    },
                                    onChanged: (val) {
                                      setState(() {});
                                      if (val.length == 10) {
                                        FocusScope.of(context).unfocus();
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 28),
                              GestureDetector(
                                onTapDown: (_) => setState(() {}),
                                onTapUp: (_) => setState(() {}),
                                child: AnimatedScale(
                                  scale: 1.0,
                                  duration: const Duration(milliseconds: 120),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 48,
                                    child: ElevatedButton(
                                      style: theme.elevatedButtonTheme.style?.copyWith(
                                        backgroundColor: MaterialStateProperty.all(colorScheme.secondary),
                                        foregroundColor: MaterialStateProperty.all(colorScheme.onSecondary),
                                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(12),
                                        )),
                                        elevation: MaterialStateProperty.all(8),
                                        shadowColor: MaterialStateProperty.all(colorScheme.secondary.withOpacity(0.3)),
                                      ),
                                      onPressed: _isLoading
                                          ? null
                                          : () async {
                                              if (_formKey.currentState!.validate()) {
                                                setState(() => _isLoading = true);
                                                await Future.delayed(const Duration(milliseconds: 800)); // Simulate loading
                                                widget.onSendOtp(_phoneController.text.replaceAll(RegExp(r'\D'), ''));
                                                setState(() => _isLoading = false);
                                              }
                                            },
                                      child: _isLoading
                                          ? const SizedBox(
                                              width: 24,
                                              height: 24,
                                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                            )
                                          : const Text(
                                              'Send OTP',
                                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'By continuing, you agree to our Terms of Service and Privacy Policy.',
                    style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 