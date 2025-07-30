import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/main_navigation.dart';
import 'screens/auth/phone_login_screen.dart';
import 'screens/auth/otp_verification_screen.dart';
import 'models/cart_provider.dart';
import 'models/bottom_nav_provider.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Prevent screenshots using platform channels
  const platform = MethodChannel('screenshot_prevention');
  try {
    await platform.invokeMethod('preventScreenshots');
  } catch (e) {
    // Handle any errors silently
  }
  
  // Prevent screenshots
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, 
    overlays: [SystemUiOverlay.bottom]);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => BottomNavProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _enableScreenshotProtection();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _enableScreenshotProtection();
    }
  }

  Future<void> _enableScreenshotProtection() async {
    try {
      const platform = MethodChannel('screenshot_prevention');
      await platform.invokeMethod('preventScreenshots');
    } catch (e) {
      // Handle any errors silently
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Course App',
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
