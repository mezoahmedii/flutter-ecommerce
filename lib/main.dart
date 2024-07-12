import 'package:ecommerce/screens/auth/views/signInScreen.dart';
import 'package:ecommerce/screens/auth/views/signUpScreen.dart';
import 'package:ecommerce/screens/home/views/homeScreen.dart';
import 'package:ecommerce/screens/home/views/productInfoScreen.dart';
import 'package:ecommerce/screens/home/views/productsScreen.dart';
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
        debugShowCheckedModeBanner: false,
        routes: {
          "/": (context) => const SignInScreen(),
          "/signUpScreen": (context) => const SignUpScreen(),
          "/homeScreen": (context) => const HomeScreen(),
          "/productsScreen": (context) => const ProductsScreen(),
          "/productInfoScreen": (context) => const ProductInfoScreen()
        });
  }
}
