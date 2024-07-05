import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextField(decoration: InputDecoration(
                labelText: "Username"
              ),),
              const TextField(obscureText: true, decoration: InputDecoration(
                  labelText: "Password"
              ),),
              ElevatedButton(onPressed: () {}, child: const Text("Sign In"))
            ],
          ),
        ),
      ),
    );
  }
}
