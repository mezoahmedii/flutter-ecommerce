import 'package:ecommerce/core/widgets/gradientBackground.dart';
import 'package:ecommerce/screens/home/logic/homeCubit.dart';
import 'package:ecommerce/screens/home/logic/homeStates.dart';
import 'package:ecommerce/screens/home/widgets/productsList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit()..getProducts(context, category),
        child: GradientBackground(
          child: Center(child:
              BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
            var cubit = HomeCubit.get(context);
            return (state is HomeLoading)
                ? const CircularProgressIndicator()
                : ProductsList(products: cubit.products);
          })),
        ),
      ),
      appBar: AppBar(
        title: const Text("Products"),
        centerTitle: true,
      ),
    );
  }
}
