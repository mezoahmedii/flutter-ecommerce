import 'package:ecommerce/screens/auth/logic/authCubit.dart';
import 'package:ecommerce/screens/auth/logic/authStates.dart';
import 'package:ecommerce/core/widgets/customButton.dart';
import 'package:ecommerce/core/widgets/customTextField.dart';
import 'package:ecommerce/core/widgets/gradientBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: GradientBackground(
          child: Center(
            child: SingleChildScrollView(
              child: BlocBuilder<AuthCubit, AuthStates>(
                builder: (context, state) {
                  var cubit = AuthCubit.get(context);
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextField(
                          label: "Email",
                          controller: cubit.emailController,
                        ),
                        CustomTextField(
                          label: "Password",
                          obscureText: true,
                          controller: cubit.passwordController,
                        ),
                        (state is AuthLoading)
                            ? const Center(child: CircularProgressIndicator())
                            : CustomButton(
                                onPressed: () {
                                  cubit.signIn(context);
                                },
                                text: "Sign In"),
                        (state is AuthLoading) ? const Text("") : Text(cubit.status),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "/signUpScreen");
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline),
                                ))
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("Sign In"),
          centerTitle: true,
        ),
      ),
    );
  }
}
