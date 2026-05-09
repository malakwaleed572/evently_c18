import 'package:evently/common/theme/app_theme.dart';

import 'package:evently/firebase_options.dart';
import 'package:evently/l10n/app_localizations.dart';

import 'package:evently/screens/auth/login_screen.dart';
import 'package:evently/screens/auth/register_screen.dart';
import 'package:evently/screens/auth/splash_screen.dart';
import 'package:evently/screens/events/add_new_events/add_new_event.dart';
import 'package:evently/screens/home/home_screen.dart';
import 'package:evently/provider/theme_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) => MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'), // English
            Locale('ar'), // Spanish
          ],
          debugShowCheckedModeBanner: false,
          routes: {
            LoginScreen.routeName: (_) => LoginScreen(),
            RegisterScreen.routeName: (_) => RegisterScreen(),
            SplashScreen.routeName: (_) => SplashScreen(),
            HomeScreen.routeName: (_) => HomeScreen(),
            AddNewEventScreen.routeName: (_) => AddNewEventScreen(),
          },
          theme: AppTheme.lightTheme,
          locale: Locale(value.appLocale),
          darkTheme: AppTheme.darktTheme,
          themeMode: value.themeMode,
        ),
      ),
    );
  }
}
