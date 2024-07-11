import 'package:ecommerce/screens/auth/logic/authCubit.dart';
import 'package:ecommerce/screens/auth/logic/authStates.dart';
import 'package:ecommerce/core/widgets/customButton.dart';
import 'package:ecommerce/core/widgets/customTextField.dart';
import 'package:ecommerce/core/widgets/gradientBackground.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                          CustomTextField(label: "Username", controller: cubit.usernameController),
                          CustomTextField(label: "Phone Number", controller: cubit.phoneNumberController,),
                          CustomTextField(label: "Email", controller: cubit.emailController,),
                          CustomTextField(
                              label: "Password", obscureText: true, controller: cubit.passwordController,),
                          (state is AuthLoading)
                              ? const Center(child: CircularProgressIndicator())
                              : CustomButton(
                              onPressed: () {
                                cubit.signUp(context);
                              },
                              text: "Sign Up"),
                          (state is AuthLoading) ? const Text("") : Text(cubit.status)
                        ],
                      ),
                    );
                  }
              ),
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text("Sign Up"),
          centerTitle: true,
        ),
      ),
    );
  }
}
