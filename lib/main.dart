import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task4/screen/command.dart';
import 'package:task4/screen/home.dart';
import 'package:task4/screen/login.dart';
import 'package:task4/screen/registeration.dart';
import 'package:task4/screen/splash.dart';

void main() async { 
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: "Login Screen",
  theme: ThemeData(
    primarySwatch: Colors.blue,
  ),
  
  initialRoute: "/",
  routes: {
    "/" :(context) => Splash(),
    "home" :(context) => Home(),
    "login" : (context) => Login(),
    "command" : (context) => Command(),
    "register" : (context) => Register(),
  },
));
}
