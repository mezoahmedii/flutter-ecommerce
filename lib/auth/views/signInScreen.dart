import 'package:ecommerce/core/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurpleAccent[100]!, Colors.deepPurple[400]!]
          )
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CustomTextField(label: "Email"),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomTextField(label: "Password", obscureText: true),
                ),
                ElevatedButton(onPressed: () {}, child: const Text("Sign In")),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(onPressed: () {
                      Navigator.pushNamed(context, "/signUpScreen");
                    }, child: const Text("Sign Up", style: TextStyle(decoration: TextDecoration.underline),))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Sign In"),
        centerTitle: true,
      ),
    );
  }
}
