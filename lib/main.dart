import 'package:evently/common/theme/app_theme.dart';
import 'package:evently/screens/auth/login_screen.dart';
import 'package:evently/screens/auth/register_screen.dart';
import 'package:evently/screens/auth/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName:(_)=>LoginScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        SplashScreen.routeName:(_)=>SplashScreen(),
      },
      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darktTheme,
      themeMode: ThemeMode.dark,
      
    );
  }
}

