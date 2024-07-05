import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: () {Navigator.pushNamed(context, "/signInScreen");}, child: const Text("Sign In Screen")),
            ElevatedButton(onPressed: () {Navigator.pushNamed(context, "/signUpScreen");}, child: const Text("Sign Up Screen"))
          ],
        ),
      )
    );
  }
}
