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
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    _hasNavigated = false;
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
    } catch (e) {
      if (mounted) {
        setState(() {
          _videoError = e.toString();
        });
      }
    }
    // Navigate to next screen after 6 seconds, regardless of video state or error
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted && !_hasNavigated) {
        _hasNavigated = true;
        _navigateToNextScreen();
      }
    });
  }

  void _navigateToNextScreen() {
    if (!mounted) return;
    
    bool isLoggedIn = false; // TODO: Replace with real login check
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => isLoggedIn
            ? const MainNavigation()
            : PhoneLoginScreen(),
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
      backgroundColor: Colors.black,
      body: _videoError != null
          ? Center(
              child: Text(
                'Failed to load video.\n$_videoError',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )
          : (_isVideoInitialized && _videoPlayerController.value.isInitialized)
              ? Center(
                  child: AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: SizedBox(
                        width: _videoPlayerController.value.size.width,
                        height: _videoPlayerController.value.size.height,
                        child: VideoPlayer(_videoPlayerController),
                      ),
                    ),
                  ),
                )
              : Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black,
                  child: Center(
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
    );
  }
} 