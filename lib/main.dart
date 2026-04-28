import 'package:evently/common/theme/app_theme.dart';
import 'package:evently/screens/auth/login_screen.dart';
import 'package:evently/screens/auth/register_screen.dart';
import 'package:evently/screens/auth/splash_screen.dart';
import 'package:evently/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async{

WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
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
       HomeScreen.routeName:(_)=>HomeScreen(),

      },
      theme: AppTheme.lightTheme,

      darkTheme: AppTheme.darktTheme,
      themeMode: ThemeMode.light,
      
    );
  }
}

