import 'package:ecommerce/core/widgets/gradientBackground.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: GradientBackground(
            child: Text("Welcome Home"),
          ),
        ),
      ),
    );
  }
}
