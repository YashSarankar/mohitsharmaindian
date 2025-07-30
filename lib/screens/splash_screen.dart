import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../theme/app_theme.dart';
import 'main_navigation.dart';
import 'auth/phone_login_screen.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _videoPlayerController;
  bool _isVideoInitialized = false;
  String? _videoError;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _videoPlayerController = VideoPlayerController.asset('assets/video/km_20250730_2160p_60f_20250730_133531.mp4');
    
    try {
      await _videoPlayerController.initialize();
      await _videoPlayerController.setLooping(false);
      await _videoPlayerController.play();
      
      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
      }

      // Listen for video completion
      _videoPlayerController.addListener(() {
        if (_videoPlayerController.value.position >= _videoPlayerController.value.duration) {
          _navigateToNextScreen();
        }
      });
      
      // Fallback timer
      Timer(Duration(seconds: 8), () {
        if (mounted) {
          _navigateToNextScreen();
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _videoError = e.toString();
        });
      }
      // If video fails, navigate after a short delay
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          _navigateToNextScreen();
        }
      });
    }
  }

  void _navigateToNextScreen() {
    if (!mounted) return;
    
    bool isLoggedIn = false; // TODO: Replace with real login check
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => isLoggedIn
            ? const MainNavigation()
            : PhoneLoginScreen(onSendOtp: (_) {}),
      ),
    );
  }

  @override
  void dispose() {
    if (_isVideoInitialized) {
      _videoPlayerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _videoError != null
          ? Center(
              child: Text(
                'Failed to load video.\n$_videoError',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : (_isVideoInitialized && _videoPlayerController.value.isInitialized)
              ? VideoPlayer(_videoPlayerController)
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ),
    );
  }
} 