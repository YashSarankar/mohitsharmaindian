import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/main_navigation.dart';
import 'screens/auth/phone_login_screen.dart';
import 'screens/auth/otp_verification_screen.dart';
import 'models/cart_provider.dart';
import 'models/bottom_nav_provider.dart';
import 'screens/splash_screen.dart';

void main() {
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

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
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
