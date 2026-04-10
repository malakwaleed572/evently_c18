import 'package:evently/common/gen/assets.gen.dart';
import 'package:evently/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String routeName = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {
        animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              AnimatedContainer(
                duration: Duration(seconds: 5,),
                curve: Curves.fastOutSlowIn,
                width: animate ? 300 : 0,
                onEnd: () {
                  Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                },

                child: Assets.images.appLogo.image(),
              ),
              Spacer(),
              Assets.images.routeLogo.image(),
              SizedBox(height: 8),
              Text(
                "Supervised by Malak Waleed",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ), //TODO localization
              SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }
}
