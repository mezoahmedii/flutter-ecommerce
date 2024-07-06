import 'package:ecommerce/core/widgets/customTextField.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                const CustomTextField(label: "Username"),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomTextField(label: "Phone Number"),
                ),
                const CustomTextField(label: "Email"),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomTextField(label: "Password", obscureText: true),
                ),
                ElevatedButton(onPressed: () {}, child: const Text("Sign Up"))
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
    );
  }
}
