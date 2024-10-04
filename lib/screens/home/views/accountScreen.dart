import 'package:ecommerce/core/utils/cache/sharedPrefs.dart';
import 'package:ecommerce/core/widgets/gradientBackground.dart';
import 'package:ecommerce/screens/home/logic/homeCubit.dart';
import 'package:ecommerce/screens/home/logic/homeStates.dart';
import 'package:ecommerce/screens/home/widgets/customNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit()..getAccount(context),
        child: GradientBackground(child: Center(child:
            BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return (state is HomeLoading)
              ? const CircularProgressIndicator()
              : SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage(cubit.currentAccount.image!),
                          radius: 48,
                        ),
                        Text(
                          cubit.currentAccount.name!,
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            SharedPrefs.prefs.remove("token");
                            Navigator.popAndPushNamed(context, "/signInScreen");
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent,
                              foregroundColor: Colors.white),
                          child: Text("Sign Out"),
                        )
                      ],
                    ),
                  ),
                );
        }))),
      ),
      appBar: AppBar(
        title: const Text("Account"),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomNavigationBar(index: 2),
    );
  }
}
