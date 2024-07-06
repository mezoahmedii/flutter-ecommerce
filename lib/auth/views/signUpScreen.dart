import 'package:ecommerce/auth/logic/authCubit.dart';
import 'package:ecommerce/auth/logic/authStates.dart';
import 'package:ecommerce/core/widgets/customButton.dart';
import 'package:ecommerce/core/widgets/customTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.deepPurpleAccent[100]!,
                    Colors.deepPurple[400]!
                  ]
              )
          ),
          child: BlocBuilder<AuthCubit, AuthStates>(
              builder: (context, state) {
                var cubit = AuthCubit.get(context);
                return Center
                  (
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextField(label: "Username", controller: cubit.usernameController),
                        CustomTextField(label: "Phone Number", controller: cubit.phoneNumberController,),
                        CustomTextField(label: "Email", controller: cubit.emailController,),
                        CustomTextField(
                            label: "Password", obscureText: true, controller: cubit.passwordController,),
                        CustomButton(onPressed: () {cubit.signIn;}, text: "Sign Up"),
                        (state is AuthLoading) ? const Text("") : Text(cubit.status)
                      ],
                    ),
                  ),
                );
              }
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
