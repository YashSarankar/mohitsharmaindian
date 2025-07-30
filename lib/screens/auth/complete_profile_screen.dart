import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:ui';
import '../../theme/app_theme.dart';
import '../../utils/location.dart';
import '../main_navigation.dart';

class CompleteProfileScreen extends StatefulWidget {
  final String phoneNumber;
  const CompleteProfileScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  DateTime? _dob;
  String? _gender;
  String? _state;
  File? _profileImage;
  bool _isLoading = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<String> _genders = ['Male', 'Female', 'Other'];
  final List<String> _states = IndianLocation.states;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeOutCubic);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _pickDOB() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _dob ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _dob = picked;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _completeProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      setState(() => _isLoading = false);
      
      // Navigate to main app
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainNavigation()),
      );
    }
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
          SafeArea(
            child: Container(
              height: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Glassmorphism card
                    Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 40),
                      child: AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) => Opacity(
                          opacity: _fadeAnimation.value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - _fadeAnimation.value)),
                            child: child,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.82),
                                borderRadius: BorderRadius.circular(16),
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
                                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Complete Your Profile',
                                        style: textTheme.titleLarge?.copyWith(
                                          fontSize: 22,
                                          color: colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'Tell us a bit about yourself to get started',
                                        style: textTheme.bodyMedium?.copyWith(
                                          fontSize: 14,
                                          color: Colors.grey[700],
                                          fontWeight: FontWeight.w500,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      // Profile Picture
                                      Center(
                                        child: GestureDetector(
                                          onTap: _pickImage,
                                          child: Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundColor: const Color(0xFFF5F5F5),
                                                backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                                                child: _profileImage == null
                                                    ? Icon(Icons.person, size: 40, color: Colors.blueGrey[300])
                                                    : null,
                                              ),
                                              Positioned(
                                                bottom: 6,
                                                right: 6,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: colorScheme.primary,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(color: Colors.white, width: 2),
                                                  ),
                                                  padding: const EdgeInsets.all(4),
                                                  child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      // First Name and Last Name
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'First Name',
                                                  style: textTheme.bodySmall?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                TextFormField(
                                                  controller: _firstNameController,
                                                  decoration: InputDecoration(
                                                    hintText: 'First Name',
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: BorderSide(color: colorScheme.primary, width: 2),
                                                    ),
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                                                  ),
                                                  validator: (value) => value == null || value.isEmpty ? 'Enter first name' : null,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Last Name',
                                                  style: textTheme.bodySmall?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                TextFormField(
                                                  controller: _lastNameController,
                                                  decoration: InputDecoration(
                                                    hintText: 'Last Name',
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: BorderSide(color: colorScheme.primary, width: 2),
                                                    ),
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                                                  ),
                                                  validator: (value) => value == null || value.isEmpty ? 'Enter last name' : null,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      // Email
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Email',
                                            style: textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          TextFormField(
                                            controller: _emailController,
                                            keyboardType: TextInputType.emailAddress,
                                            decoration: InputDecoration(
                                              hintText: 'Enter your email',
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(color: colorScheme.primary, width: 2),
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                                            ),
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter your email';
                                              }
                                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                                                return 'Please enter a valid email';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      // DOB and Gender
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Date of Birth',
                                                  style: textTheme.bodySmall?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                GestureDetector(
                                                  onTap: _pickDOB,
                                                  child: Container(
                                                    height: 48,
                                                    padding: const EdgeInsets.symmetric(horizontal: 14),
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10),
                                                      border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                                                        const SizedBox(width: 6),
                                                        Expanded(
                                                          child: Text(
                                                            _dob == null ? 'Select date' : '${_dob!.day}/${_dob!.month}/${_dob!.year}',
                                                            style: textTheme.bodySmall?.copyWith(color: _dob == null ? Colors.grey[600] : Colors.black87),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Gender',
                                                  style: textTheme.bodySmall?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.grey[800],
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                DropdownButtonFormField<String>(
                                                  value: _gender,
                                                  hint: const Text('---', style: TextStyle(color: Colors.grey)),
                                                  items: _genders.map((g) => DropdownMenuItem(
                                                    value: g,
                                                    child: Text(g, style: textTheme.bodySmall),
                                                  )).toList(),
                                                  onChanged: (val) => setState(() => _gender = val),
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(10),
                                                      borderSide: BorderSide(color: colorScheme.primary, width: 2),
                                                    ),
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                                                  ),
                                                  validator: (value) => value == null || value.isEmpty ? 'Select gender' : null,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      // State
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'State',
                                            style: textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          DropdownButtonFormField<String>(
                                            value: _state,
                                            hint: const Text('---', style: TextStyle(color: Colors.grey)),
                                            items: _states.map((s) => DropdownMenuItem(
                                              value: s,
                                              child: Text(s, style: textTheme.bodySmall),
                                            )).toList(),
                                            onChanged: (val) => setState(() => _state = val),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: BorderSide(color: colorScheme.primary, width: 2),
                                              ),
                                              contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                                            ),
                                            validator: (value) => value == null || value.isEmpty ? 'Select state' : null,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 24),
                                      // Complete Profile Button
                                      SizedBox(
                                        width: double.infinity,
                                        height: 44,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: colorScheme.secondary,
                                            foregroundColor: colorScheme.onSecondary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                            elevation: 6,
                                            shadowColor: colorScheme.secondary.withOpacity(0.3),
                                          ),
                                          onPressed: _isLoading ? null : _completeProfile,
                                          child: _isLoading
                                              ? const SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                                                )
                                              : const Text(
                                                  'Complete Profile',
                                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
          ),
        ],
      ),
    );
  }
} 