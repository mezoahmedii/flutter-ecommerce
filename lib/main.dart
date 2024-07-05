import 'package:ecommerce/auth/views/homeScreen.dart';
import 'package:ecommerce/auth/views/signInScreen.dart';
import 'package:ecommerce/auth/views/signUpScreen.dart';
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
      title: 'Flutter Ecommerce',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const HomeScreen(),
        "/signInScreen": (context) => const SignInScreen(),
        "/signUpScreen": (context) => const SignUpScreen(),
      }
    );
  }
}