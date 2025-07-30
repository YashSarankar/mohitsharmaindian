import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:mohitsharmaindian/screens/home/home_screen.dart';
import 'package:mohitsharmaindian/screens/main_navigation.dart';
import 'package:pinput/pinput.dart';
import 'dart:math';
import 'complete_profile_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback onVerified;
  const OtpVerificationScreen({Key? key, required this.phoneNumber, required this.onVerified}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  String _otpValue = '';
  bool _isLoading = false;
  bool _hasError = false;
  int _timerSeconds = 30;
  Timer? _timer;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _timerSeconds = 30);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds == 0) {
        timer.cancel();
      } else {
        setState(() => _timerSeconds--);
      }
    });
  }

  Future<void> _onVerify() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });
    await Future.delayed(const Duration(seconds: 1)); // Simulate network
    // Simulate error for demo (replace with real logic)
    if (_otpValue != '1234') {
      setState(() {
        _hasError = true;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
      // Navigate to complete profile screen after successful verification
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => CompleteProfileScreen(phoneNumber: widget.phoneNumber))
      );
      // If you want to call widget.onVerified() as well, you can do so here
      // widget.onVerified();
    }
  }

  void _onResend() {
    setState(() {
    });
    _startTimer();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP resent!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final size = MediaQuery.of(context).size;
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
                  // Blurred animated blob
                  Positioned(
                    top: 60,
                    left: -80,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.primary.withOpacity(0.13),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                        child: const SizedBox(),
                      ),
                    ),
                  ),
                  // Another blob
                  Positioned(
                    bottom: -60,
                    right: -60,
                    child: AnimatedContainer(
                      duration: const Duration(seconds: 2),
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.secondary.withOpacity(0.10),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
                        child: const SizedBox(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Decorative animated bubble in the top-left corner (like phone login)
          Positioned(
            top: -size.width * 0.2,
            left: -size.width * 0.2,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.7, end: 1),
              duration: const Duration(milliseconds: 900),
              curve: Curves.elasticOut,
              builder: (context, value, child) => Transform.scale(
                scale: value,
                child: child,
              ),
              child: Container(
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
          ),
          // Decorative animated bubble in the bottom-right corner (like phone login)
          Positioned(
            bottom: -size.width * 0.18,
            right: -size.width * 0.18,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(begin: 0.7, end: 1),
              duration: const Duration(milliseconds: 900),
              curve: Curves.elasticOut,
              builder: (context, value, child) => Transform.scale(
                scale: value,
                child: child,
              ),
              child: Container(
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
          ),
          Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.height * 0.04),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Logo
                  Container(
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
                        height: 72,
                        width: 72,
                        fit: BoxFit.cover,
                        semanticLabel: 'App Logo',
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Glassmorphism card
                  AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) => Opacity(
                      opacity: _fadeAnimation.value,
                      child: Transform.translate(
                        offset: Offset(0, 40 * (1 - _fadeAnimation.value)),
                        child: child,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.82),
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: colorScheme.primary.withOpacity(0.08)),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.primary.withOpacity(0.10),
                                blurRadius: 32,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Verification',
                                  style: textTheme.titleLarge?.copyWith(
                                    fontSize: 24,
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'We’ve sent a 4-digit code to your mobile number.',
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontSize: 16,
                                    color: Colors.grey[700],
                                    fontWeight: FontWeight.w500,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '+91 ${widget.phoneNumber}',
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: colorScheme.primary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 28),
                                // PIN-style OTP input using pin_code_fields
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      Pinput(
                                        length: 4,
                                        autofocus: true,
                                        controller: _otpController,
                                        defaultPinTheme: PinTheme(
                                          width: 56,
                                          height: 56,
                                          textStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 28, letterSpacing: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(18),
                                            border: Border.all(color: _hasError ? Colors.red : Colors.grey[300]!, width: 1),
                                          ),
                                        ),
                                        focusedPinTheme: PinTheme(
                                          width: 56,
                                          height: 56,
                                          textStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 28, letterSpacing: 2),
                                          decoration: BoxDecoration(
                                            color: colorScheme.primary.withOpacity(0.08),
                                            borderRadius: BorderRadius.circular(18),
                                            border: Border.all(color: colorScheme.primary, width: 1.5),
                                          ),
                                        ),
                                        submittedPinTheme: PinTheme(
                                          width: 56,
                                          height: 56,
                                          textStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 28, letterSpacing: 2),
                                          decoration: BoxDecoration(
                                            color: colorScheme.primary.withOpacity(0.04),
                                            borderRadius: BorderRadius.circular(18),
                                            border: Border.all(color: colorScheme.primary, width: 1),
                                          ),
                                        ),
                                        errorPinTheme: PinTheme(
                                          width: 56,
                                          height: 56,
                                          textStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontSize: 28, letterSpacing: 2, color: Colors.red),
                                          decoration: BoxDecoration(
                                            color: Colors.red.withOpacity(0.04),
                                            borderRadius: BorderRadius.circular(18),
                                            border: Border.all(color: Colors.red, width: 1),
                                          ),
                                        ),
                                        showCursor: true,
                                        cursor: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            width: 24,
                                            height: 1.5,
                                            margin: const EdgeInsets.only(bottom: 4),
                                            decoration: BoxDecoration(
                                              color: colorScheme.primary,
                                              borderRadius: BorderRadius.circular(1),
                                            ),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) {
                                          setState(() {
                                            _otpValue = value;
                                            _hasError = false;
                                          });
                                        },
                                        onCompleted: (value) {
                                          setState(() {
                                            _otpValue = value;
                                          });
                                          if (value.length == 4) _onVerify();
                                        },
                                        errorText: _hasError ? 'Invalid OTP. Please try again.' : null,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 32),
                                SizedBox(
                                  width: double.infinity,
                                  height: 48,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.secondary,
                                      foregroundColor: colorScheme.onSecondary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      elevation: 8,
                                      shadowColor: colorScheme.secondary.withOpacity(0.3),
                                    ),
                                    onPressed: _isLoading
                                        ? null
                                        : () {
                                            if (_formKey.currentState!.validate() && _otpValue.length == 4) {
                                              _onVerify();
                                            }
                                          },
                                    child: _isLoading
                                        ? const SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                          )
                                        : const Text(
                                            'Verify',
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 18),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (_timerSeconds > 0)
                                      Row(
                                        children: [
                                          Text(
                                            'Resend in $_timerSeconds s',
                                            style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 8.0),
                                            child: SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  CircularProgressIndicator(
                                                    value: (30 - _timerSeconds) / 30,
                                                    strokeWidth: 2.2,
                                                    color: colorScheme.primary,
                                                  ),
                                                  Icon(Icons.lock_clock, size: 14, color: colorScheme.primary.withOpacity(0.7)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    else
                                      GestureDetector(
                                        onTap: _onResend,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          child: Text(
                                            'Resend OTP',
                                            style: textTheme.bodyMedium?.copyWith(
                                              color: colorScheme.primary,
                                              fontWeight: FontWeight.w600,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 