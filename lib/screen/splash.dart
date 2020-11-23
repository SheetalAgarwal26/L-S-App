import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:task4/screen/home.dart';
import 'package:page_transition/page_transition.dart';


class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Linux App",
        home: AnimatedSplashScreen(
          duration: 2000,
          splash: Image.asset("assets/a.png",fit: BoxFit.fill,height: 500,),
          nextScreen: MainScreen(),
          splashTransition: SplashTransition.scaleTransition,
          pageTransitionType: PageTransitionType.leftToRightWithFade,
          backgroundColor: Colors.yellow[700],
        ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}