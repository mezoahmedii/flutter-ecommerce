import 'package:ecommerce/core/widgets/gradientBackground.dart';
import 'package:ecommerce/screens/home/logic/homeCubit.dart';
import 'package:ecommerce/screens/home/logic/homeStates.dart';
import 'package:ecommerce/screens/home/widgets/categoriesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit()..getCategories(context),
        child: GradientBackground(
          child: Center(
            child:
                BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
              var cubit = HomeCubit.get(context);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Choose a category:",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 150,
                    child: (state is HomeLoading)
                        ? const Center(
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : CategoriesList(
                            categories: cubit.categories,
                          ),
                  )
                ],
              );
            }),
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text("Home"),
        centerTitle: true,
      ),
    );
  }
}
