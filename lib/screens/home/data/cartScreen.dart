import 'package:ecommerce/core/widgets/gradientBackground.dart';
import 'package:ecommerce/screens/home/logic/homeCubit.dart';
import 'package:ecommerce/screens/home/logic/homeStates.dart';
import 'package:ecommerce/screens/home/widgets/customNavigationBar.dart';
import 'package:ecommerce/screens/home/widgets/productsList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit()..getCart(context),
        child: GradientBackground(child: Center(child:
            BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return (state is HomeLoading)
              ? const CircularProgressIndicator()
              : ProductsList(products: cubit.cart);
        }))),
      ),
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      bottomNavigationBar: CustomNavigationBar(index: 1),
    );
  }
}
