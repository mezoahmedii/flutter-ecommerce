import 'package:ecommerce/core/widgets/customButton.dart';
import 'package:ecommerce/core/widgets/gradientBackground.dart';
import 'package:ecommerce/screens/home/logic/homeCubit.dart';
import 'package:ecommerce/screens/home/logic/homeStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductInfoScreen extends StatelessWidget {
  const ProductInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit()..getProductInfo(context, product),
        child: GradientBackground(
          child: Center(child: SingleChildScrollView(
            child:
                BlocBuilder<HomeCubit, HomeStates>(builder: (context, state) {
              var cubit = HomeCubit.get(context);
              return (state is HomeLoading)
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(cubit.currentProduct.image!),
                            Text(cubit.currentProduct.name!,
                                style: const TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold)),
                            Text(cubit.currentProduct.description!),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomButton(
                                      onPressed: () {}, text: "Add to Cart"),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  (cubit.currentProduct.discount != 0)
                                      ? Row(
                                          children: [
                                            Text(
                                                "\$${cubit.currentProduct.oldPrice!}  ",
                                                style: const TextStyle(
                                                    decoration: TextDecoration
                                                        .lineThrough,
                                                    color: Colors.black54)),
                                            Text(
                                                "\$${cubit.currentProduct.price!}")
                                          ],
                                        )
                                      : Text(
                                          "\$${cubit.currentProduct.price!}"),
                                ])
                          ],
                        ),
                      ),
                    );
            }),
          )),
        ),
      ),
      appBar: AppBar(
        title: const Text("Product Info"),
        centerTitle: true,
      ),
    );
  }
}
